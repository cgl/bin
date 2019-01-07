#!/bin/bash

helptext="
$(basename "$0") -f -c 1597 -m extend-newsletter-api
 Sets up branch 'feature/COG-1597-extend-newsletter-api' to track remote branch 'master' from 'origin'.

$(basename "$0") -d -f -c 1597 -m extend-newsletter-api
 Sets up branch 'feature/COG-1597-extend-newsletter-api' to track remote branch 'development' from 'origin'.

$(basename "$0") -b -c 1597 -m fix-newsletter-api
 Sets up branch 'fix/COG-1597-fix-newsletter-api' to track remote branch 'master' from 'origin'.

$(basename "$0") -c 1597 -m extend-newsletter-api
 Sets up branch 'chore/COG-1597-extend-newsletter-api' to track remote branch 'master' from 'origin'.

$(basename "$0") -r -v 0.11.8
 Sets up branch 'release/0.11.8' to track remote branch 'master' from 'origin'.
"
type="chore"
basebranch="origin/master"
while [[ "$#" > 0 ]]; do case $1 in
  -m|--message) message="-$2"; shift;;
  -c|--cardid) cardid="COG-$2"; shift;;
  -f|--feature) type="feature";;
  -b|--bugfix) type="fix";;
  -d|--dev-as-base) basebranch="origin/development";;
  -r|--release) type="release";;
  -v|--version) version=$2; shift;;
  -h|--help) echo "$helptext"; exit;;
  *) echo "Unknown parameter passed: $1"; exit 1;;
esac; shift; done
branchname="$type/$version$cardid$message"
echo "Creating branch $branchname"
git fetch
git checkout -b $branchname $basebranch
