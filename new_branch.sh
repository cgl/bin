#!/bin/bash

helptext="
$(basename "$0") -f -c 1597 -m extend-newsletter-api
 feature/COG-1597-extend-newsletter-api

$(basename "$0") -b -c 1597 -m extend-newsletter-api
 fix/COG-1597-extend-newsletter-api

$(basename "$0") -c 1597 -m extend-newsletter-api
 chore/COG-1597-extend-newsletter-api

$(basename "$0") -r -v 0.11.8
 release/0.11.8
"
type="chore"
while [[ "$#" > 0 ]]; do case $1 in
  -m|--message) message="-$2"; shift;;
  -c|--cardid) cardid="COG-$2"; shift;;
  -f|--feature) type="feature";;
  -b|--bugfix) type="fix";;
  -r|--release) type="release";;
  -v|--version) version=$2; shift;;
  -h|--help) echo "$helptext"; exit;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done
branchname="$type/$version$cardid$message"
echo "Creating branch $branchname"
git fetch
git checkout -b $branchname origin/master
