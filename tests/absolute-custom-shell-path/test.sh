#!/bin/bash
set -e -o pipefail

../../script/signal-fanout /bin/sh script.sh
