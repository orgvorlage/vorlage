#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
if(TARGET vanadium_coverage)
  # This module has already been processed. Don't do it again.
  return()
endif()
add_custom_target(vanadium_coverage)

set(
  VANADIUM_COVERAGE_OUTPUT_DIRECTORY
  ${PROJECT_BINARY_DIR}/vanadium/coverage
  CACHE PATH
  "Path to Store Output of Coverage Data"
  )

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  include(${CMAKE_CURRENT_LIST_DIR}/coverage/clang.cmake)
else()
  message(FATAL_ERROR "Coverage: Unsupported for ${CMAKE_CXX_COMPILER_ID} Compiler.")
endif()

