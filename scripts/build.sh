#!/bin/bash
srcdir="src"
targetdir="build"
tmpdir="$targetdir/tmp"

echo "Building..."

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

# Process sass files
sassc styles.scss styles.css

# Convert LaTeX examples to pdf
tex_to_png() {
  filename=$(basename -- "$1")
  filename="${filename%.*}"
  xelatex "$1"
  pdftoppm "$filename.pdf" "$filename" -png 
}

cd docs || exit
for tex_file in ./*.tex ; do
  tex_to_png "$tex_file"
done
cd ./.. || exit

# Render rmarkdown
./render.R
