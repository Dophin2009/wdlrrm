#!/bin/sh
script_dir=scripts
script_build=$script_dir/build.sh
script_clean=$script_dir/clean.sh
script_checkcmd=$script_dir/check_cmd.sh

# Define shutdown process
shutdown() {
  PGID=$(ps -o pgid= $$ | grep -o [0-9]*)
  kill -9 -$PGID
  exit 0
}

trap "shutdown" SIGINT SIGTERM EXIT

# Check if required commands exist
declare -a req_commands=("python3" "inotifywait")
for c in "${req_commands[@]}"; do
  $script_checkcmd "$c" || exit
done

# Initial build
$script_build

# Start http server
python3 -m http.server 5200 --directory build &

# Watch for changes in src and rebuild
inotifywait -e modify \
  -r -q -m src |
while read ; do
  $script_clean || exit
  $script_build || exit
done
