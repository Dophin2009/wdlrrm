#!/bin/bash
command -v $1 >/dev/null 2>&1 || { echo "$1 required, but not found. Exiting" >&2; exit 1; }
