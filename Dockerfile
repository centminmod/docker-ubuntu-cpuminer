FROM ubuntu:zesty
MAINTAINER George Liu <https://github.com/centminmod/docker-ubuntu-cpuminer>
# https://moneropool.com/#getting_started
# update-alternatives --config gcc
ENV GIT_URL https://github.com/wolf9466/cpuminer-multi.git
ENV POOL_URL mine.moneropool.com:3333
RUN ulimit -c -m -s -t unlimited && apt-get update && apt-get -y install dirmngr wget apt-utils libcurl3 build-essential libjansson-dev git make automake bc libcurl4-openssl-dev
RUN touch /etc/apt/sources.list.d/gcc7.list && echo "deb http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu zesty main " >> /etc/apt/sources.list.d/gcc7.list && echo "deb-src http://ppa.launchpad.net/ubuntu-toolchain-r/test/ubuntu zesty main " >> /etc/apt/sources.list.d/gcc7.list && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 60C317803A41BA51845E371A1E9377A2BA9EF27F
RUN apt-get -y install gcc-7 g++-7 && update-alternatives --remove-all gcc && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 70 --slave /usr/bin/g++ g++ /usr/bin/g++-7 && update-alternatives --set gcc "/usr/bin/gcc-7"
RUN git clone ${GIT_URL} cpuminer && cd cpuminer && ./autogen.sh -m4_pattern_allow && CFLAGS="-O3" ./configure && make -j"$(/bin/grep -c "processor" /proc/cpuinfo)" && THREADS=$(/usr/bin/lscpu | /usr/bin/awk '/^L3/ {l3=sprintf("%u", $NF)/1024} /^Socket/ {sockets=sprintf("%u", $NF)} END {print l3*sockets/2}') && apt-get clean && apt-get autoclean && apt-get remove && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /cpuminer
CMD ./minerd -a cryptonight -o stratum+tcp://${POOL_URL} -p x -u $WALLETADDR -t $THREADS

