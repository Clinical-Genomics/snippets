#!/bin/bash

# returns a list with the amount of files per filesize-bin. The bin-size is 1KB.

find . -type f -exec ls -lh {} \; | gawk '{match($5,/([0-9.]+)([A-Z]+)/,k); if(!k[2]){print "1K"} else {printf "%.0f%s\n",k[1],k[2]}}' | sort | uniq -c | sort -hk 2
