#!/bin/bash
script_dir=scripts
script_checkcmd=$script_dir/check_cmd.sh

# Check if required commands exist
declare -a req_commands=("sassc" "xelatex" "pandoc" "pandoc-include-code" "pdftoppm")
for c in "${req_commands[@]}"; do
  $script_checkcmd "$c" || exit
done

srcdir="src"
targetdir="build"
tmpdir="$targetdir/tmp"

# Create target dir if not exist
if [ ! -d $targetdir ]; then
  mkdir $targetdir
fi

if [ ! -d $tmpdir ]; then
  mkdir $tmpdir
fi

# Copy src dir
cp -r $srcdir/* $tmpdir/
cp scripts/render.R $tmpdir/render.R

cd $tmpdir || exit

# Render rmarkdown
./render.R
