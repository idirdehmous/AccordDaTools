#!/usr/bin/env bash

set -uex

# A unique working directory
wd=$(pwd)
test_wd=$(pwd)/test_tuneBR_help

mkdir -p ${test_wd}
cd ${test_wd}

tuneBR.py -h  > /dev/null && echo "tuneBR.py help/usage works"


# Clean up
cd ${wd}
rm -rf ${test_wd}
