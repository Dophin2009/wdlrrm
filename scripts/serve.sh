#!/bin/sh
echo "Serving..."

set -e

# Start http server
python -m http.server 5200 --directory build &
http_pid=$!

close() {
  echo "Interrupt recieved, killing http server"
  kill -9 $http_pid
  exit 1
}
trap '{ close }' INT

# Watch for changes in src and rebuild
inotifywait -e modify \
  -r -q -m src |
while read ; do
  scripts/clean.sh || close
  scripts/build.sh || close
done
