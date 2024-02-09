#!/usr/bin/env bash

set -euxo pipefail

shopt -s globstar

dir="$1"
ext="$2"
lang="$3"

temppdf="$(mktemp --suffix='.pdf')"

img2pdf "$dir"/*."$ext" -o "$temppdf" && \
	ocrmypdf -l "$lang" "$temppdf" "$(basename "$dir")_ocred.pdf" && \
		rm -f "$temppdf"
