#!/bin/bash
script_dir=scripts
script_checkcmd=$script_dir/check_cmd.sh

# Check if required commands exist
declare -a req_commands=("python3")
for c in "${req_commands[@]}"; do
  $script_checkcmd "$c" || exit
done

# Start http server
python3 -m http.server 5200 --directory "$1"
