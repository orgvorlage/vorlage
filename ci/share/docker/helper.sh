#!/bin/bash
#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------

docker_generate_name()
{
  if [ "$#" -ne 1 ]; then
    echo "Function provided with $# arguments."
    echo "Function requires"
    echo "1. Project Name"
    return 0
  fi

  PROJECT_NAME=$1
  NAME=$(head -c 1024 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 32)
  export CONTAINER_NAME=$PROJECT_NAME-ci-$NAME
}

docker_create_container()
{
  if [ "$#" -ne 5 ]; then
    echo "Function provided with $# arguments."
    echo "Function requires"
    echo "1. Docker Image"
    echo "2. Container"
    echo "3. Source Directory"
    echo "4. Working Directory"
    echo "5. Input Data"
    return 0
  fi

  DOCKER_IMAGE=$1
  CONTAINER_NAME=$2
  SOURCE_DIRECTORY=$3
  WORKING_DIRECTORY=$4
  INPUT_DATA=$5

  docker run \
    -t -d --network=host --cap-add SYS_PTRACE \
    --name ${CONTAINER_NAME} \
    --mount source=$SOURCE_DIRECTORY,destination=/tmp/src,type=bind \
    --mount source=$WORKING_DIRECTORY,destination=/tmp/working,type=bind \
    --mount source=$INPUT_DATA,destination=/tmp/input_data,type=bind,readonly \
    ${DOCKER_IMAGE} \
    bash
}


docker_execute_script()
{
  CONTAINER_NAME=$1
  shift
  ARGUMENTS=''
  for i in "$@"; do
      i="${i//\\/\\\\}"
      ARGUMENTS="$ARGUMENTS \"${i//\"/\\\"}\""
  done
  docker exec -w /tmp/src $CONTAINER_NAME /bin/bash -c "$ARGUMENTS"
}


docker_cleanup_container()
{
  if [ "$#" -ne 1 ]; then
    echo "Function provided with $# arguments."
    echo "Function requires"
    echo "1. Container"
    return 0
  fi

  CONTAINER_NAME=$1
  docker stop ${CONTAINER_NAME}
  docker rm ${CONTAINER_NAME}
}
