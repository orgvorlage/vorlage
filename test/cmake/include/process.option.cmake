#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------

################################################################################
# Process Test Mode Arguments
################################################################################
foreach(TEST_MODE ${TEST_MODE_LIST})
  if(NOT TEST_MODE IN_LIST TEST_MODE_FULL_LIST)
    message(FATAL_ERROR "
    Unknown Test Mode: ${TEST_MODE}
    Supported Test Modes: ${TEST_MODE_FULL_LIST}
    ")
  endif()
endforeach()

if("All" IN_LIST TEST_MODE_LIST)
  list(LENGTH TEST_MODE_LIST TEST_MODE_LIST_LENGTH)
  if(NOT ${TEST_MODE_LIST_LENGTH} EQUAL 1)
    message(FATAL_ERROR
      "
      Test Modes Specified: ${TEST_MODE_LIST}
      No other test mode can be specified along with All.
      ")
  endif()
endif()

################################################################################
# Process Input and Output Data Paths
################################################################################
if(NOT DEFINED INPUT_DATA)
  message(FATAL_ERROR "INPUT_DATA is required to be specified for building tests.")
endif()
file(
  REAL_PATH
  ${INPUT_DATA}
  TEST_INPUT_DATA_ABSPATH
  BASE_DIRECTORY ${CMAKE_BINARY_DIR}
  )

if(NOT DEFINED OUTPUT_DATA)
  message(FATAL_ERROR "OUTPUT_DATA is required to be specified for building tests.")
endif()
file(
  REAL_PATH
  ${OUTPUT_DATA}
  TEST_OUTPUT_DATA_ABSPATH
  BASE_DIRECTORY
  ${CMAKE_BINARY_DIR}
  )
string(TIMESTAMP TIME_STRING %s UTC)
string(APPEND TEST_OUTPUT_DATA_ABSPATH "/test/${TIME_STRING}")
