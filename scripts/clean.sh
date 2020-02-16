#!/bin/bash
targetdir=build
tmpdir=$targetdir/tmp

if [ -d "$tmpdir/cache" ] ; then
  cp -r "$tmpdir/cache" "$targetdir/"
fi

rm -rf $tmpdir
