#!/bin/bash

sh -c 'for i in $(seq 1 10); do echo "background process: $(date)"; sleep 1; done' &
sh -c 'for i in $(seq 1 10); do echo "foreground process: $(date)"; sleep 1; done'
