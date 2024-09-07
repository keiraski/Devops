#!/bin/bash
gcc server.c -o server -lfcgi
spawn-fcgi -p 8080 ./server
service nginx start
/bin/bash