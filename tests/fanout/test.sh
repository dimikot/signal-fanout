#!/bin/bash
set -e -o pipefail

echo "Spawining a new session in background"
../../script/signal-fanout script.sh & pid=$!

sleep 1
pid_sess=$(($(ps -o sess= -p "$pid")))
pstree -ap | grep -E "spawnclient|bash|sh,|signal-fanout|sleep" | grep -v grep

echo "Killing $pid now (sess=$pid_sess)"
# Don't test with SIGINT here: it won't work. Use some other signal (like
# SIGHUP). Bash corrupts SIGINT handling when "&" is used above, which is
# specific for this test only. It doesn't happen when the real GitHub Action
# Runner sends a SIGINT to singal-fanout process though.
kill -SIGHUP "$pid"

sleep 1
pids=$(pgrep -s $pid_sess || true)
if [[ "$pids" != "" ]]; then
  echo "Error: some processes continue runing:"
  # shellcheck disable=SC2086
  ps -o pid,sess,pgid,command -p $pids
  exit 1
fi

echo ok
