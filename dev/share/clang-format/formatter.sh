#!/bin/bash
#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------

format_code()
{
  if [ "$#" -ne 2 ]; then
    echo "Script provided with $# arguments."
    echo "Script requires"
    echo "1. git-clang-format binary"
    echo "2. clang-format binary"
    return 1
  fi

  GIT_CLANG_FORMAT=$1
  CLANG_FORMAT=$2

  set +e

  git rev-parse --verify HEAD^ > /dev/null 2> /dev/null
  HEAD_EXISTS=$?

  if [[ $HEAD_EXISTS == 0 ]]; then
    echo "Running Incremental Format..."
    $GIT_CLANG_FORMAT --binary $CLANG_FORMAT HEAD^
    RETURN_CODE=$?
  else
    echo "Initial Commit. Running Complete Format..."
    RETURN_CODE=0
    ALLFILES=$(find . -name '*.hpp' -o -name '*.ipp'  -o -name '*.cpp')
    for FILE in $ALLFILES; do
      $CLANG_FORMAT $FILE | cmp -s $FILE -
      if [ $? -ne 0 ]; then
        echo "Incorrectly Formatted: $FILE"
        $CLANG_FORMAT -i $FILE
        RETURN_CODE=1
      fi
    done
  fi
  return $RETURN_CODE
}
