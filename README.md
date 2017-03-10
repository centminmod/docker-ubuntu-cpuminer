[cpuminer](https://github.com/wolf9466/cpuminer-multi) docker image on Ubuntu Zesty
=================

* Default URL=mine.moneropool.com:3333. 
* Need to pass your Monero wallet address for WALLETADDR variable.
* Right now you need to manually set THREADS variable so 2 SSH commands to run would be

2 commands to run to calculate the number of threads and assign to THREADS variable and the docker run command

    THREADS=$(lscpu | awk '/^L3/ {l3=sprintf("%u", $NF)/1024} /^Socket/ {sockets=sprintf("%u", $NF)} END {print l3*sockets/2}')
    docker run --name cpuminer -d -e URL=<POOL_URL> -e WALLETADDR=<MONERO_ADDRESS> -e THREADS=$THREDS centminmod/docker-ubuntu-cpuminer

`minerd` options


    ./minerd -h
    Usage: minerd [OPTIONS]
    Options:
      -o, --url=URL         URL of mining server
      -O, --userpass=U:P    username:password pair for mining server
      -u, --user=USERNAME   username for mining server
      -p, --pass=PASSWORD   password for mining server
          --cert=FILE       certificate for mining server using SSL
      -x, --proxy=[PROTOCOL://]HOST[:PORT]  connect through a proxy
      -t, --threads=N       number of miner threads (default: number of processors)
      -r, --retries=N       number of times to retry if a network call fails
                              (default: retry indefinitely)
      -R, --retry-pause=N   time to pause between retries, in seconds (default: 30)
      -T, --timeout=N       timeout for long polling, in seconds (default: none)
      -s, --scantime=N      upper bound on time spent scanning current work when
                              long polling is unavailable, in seconds (default: 5)
          --no-longpoll     disable X-Long-Polling support
          --no-stratum      disable X-Stratum support
          --no-redirect     ignore requests to change the URL of the mining server
      -q, --quiet           disable per-thread hashmeter output
      -D, --debug           enable debug output
      -P, --protocol-dump   verbose dump of protocol-level activities
      -S, --syslog          use system log for output messages
      -B, --background      run the miner in the background
          --benchmark       run in offline benchmark mode
      -c, --config=FILE     load a JSON-format configuration file
      -V, --version         display version information and exit
      -h, --help            display this help text and exit
