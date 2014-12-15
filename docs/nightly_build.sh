#!/bin/sh
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH
cd /Users/documentation/Sites/arlab_docs

echo "pulling changes"
hg -v pull 2>&1 > nightly_build.log
echo "updating source"
hg -v update 2>&1 > nightly_build.log

make html