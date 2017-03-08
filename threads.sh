#!/bin/bash
######################################################
THREADS=$(/usr/bin/lscpu | /usr/bin/awk '/^L3/ {l3=sprintf("%u", $NF)/1024} /^Socket/ {sockets=sprintf("%u", $NF)} END {print l3*sockets/2}')"