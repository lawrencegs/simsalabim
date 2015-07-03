#!/bin/bash

var='printf "flush_all\nquit\n" | nc -q -1 127.1 11211'
eval $var