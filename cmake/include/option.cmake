#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
################################################################################
# Library Options
################################################################################
set(BUILD_MODE_ARRAY "Normal")
set(BUILD_MODE "Normal" CACHE STRING "Build Mode")
set_property(
  CACHE BUILD_MODE PROPERTY STRINGS ${BUILD_MODE_ARRAY})
if(NOT BUILD_MODE IN_LIST BUILD_MODE_ARRAY)
  message(FATAL_ERROR "
  Unsupported Build Mode ${BUILD_MODE} Requested
  Supported Build Modes: ${BUILD_MODE_ARRAY}\n\
  Provided Value for BUILD_MODE : ${BUILD_MODE}\n\
  "
  )
endif()


################################################################################
# Testing Option
################################################################################
option(BUILD_BENCHMARKING "Build Benchmarks" OFF)
option(BUILD_TESTING "Build Tests" OFF)

################################################################################
# Input Data
################################################################################
if(BUILD_BENCHMARKING OR BUILD_TESTING)
  string(TIMESTAMP TIME_STRING %s UTC)

  if(NOT DEFINED INPUT_DATA)
    message(FATAL_ERROR "INPUT_DATA is required to be specified for tests.")
  endif()
  get_filename_component(INPUT_DATA_ABSPATH ${INPUT_DATA} ABSOLUTE)

  if(NOT DEFINED OUTPUT_DATA)
    message(FATAL_ERROR "OUTPUT_DATA is required to be specified for tests.")
  endif()
  get_filename_component(OUTPUT_DATA_ABSPATH ${OUTPUT_DATA} ABSOLUTE)
  string(APPEND OUTPUT_DATA_ABSPATH "/${TIME_STRING}")
endif()

################################################################################
# Benchmarking Options
################################################################################
if(BUILD_BENCHMARKING)
  set(BENCHMARK_MODE_ARRAY "Normal")
  set(BENCHMARK_MODE "Normal" CACHE STRING "Test Mode")
  set_property(
    CACHE BENCHMARK_MODE PROPERTY STRINGS ${BENCHMARK_MODE_ARRAY})
  if(NOT BENCHMARK_MODE IN_LIST BENCHMARK_MODE_ARRAY)
    message(FATAL_ERROR "
    Unsupported Test Mode ${BENCHMARK_MODE} Requested
    Supported Test Modes: ${BENCHMARK_MODE_ARRAY}\n\
    Provided Value for BENCHMARK_MODE : ${BENCHMARK_MODE}\n\
    "
    )
endif()
endif()

################################################################################
# Testing Options
################################################################################
if(BUILD_TESTING)
  set(TEST_MODE_ARRAY "Normal")
  set(TEST_MODE "Normal" CACHE STRING "Test Mode")
  set_property(
    CACHE TEST_MODE PROPERTY STRINGS ${TEST_MODE_ARRAY})
  if(NOT TEST_MODE IN_LIST TEST_MODE_ARRAY)
    message(FATAL_ERROR "
    Unsupported Test Mode ${TEST_MODE} Requested
    Supported Test Modes: ${TEST_MODE_ARRAY}\n\
    Provided Value for TEST_MODE : ${TEST_MODE}\n\
    "
    )
endif()
endif()
