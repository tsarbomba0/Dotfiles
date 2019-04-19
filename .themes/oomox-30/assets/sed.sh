#!/bin/sh
sed -i \
         -e 's/#dfe2e6/rgb(0%,0%,0%)/g' \
         -e 's/#0a0a0a/rgb(100%,100%,100%)/g' \
    -e 's/#0a0a0a/rgb(50%,0%,0%)/g' \
     -e 's/#414a5c/rgb(0%,50%,0%)/g' \
     -e 's/#ffffff/rgb(50%,0%,50%)/g' \
     -e 's/#0a0a0a/rgb(0%,0%,50%)/g' \
	"$@"
