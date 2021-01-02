#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
get_directory_property(HASPARENT PARENT_DIRECTORY)
if(NOT HASPARENT)
  cmake_minimum_required(VERSION 3.19)
  project(testvorlage)
  include(cmake/include/system.cmake)
endif()
include(cmake/include/unit_test.cmake)

include(cmake/include/option.cmake)
include(cmake/include/process.option.cmake)
include(cmake/include/external.cmake)

add_library(libtest)
set_target_properties(libtest PROPERTIES OUTPUT_NAME test)
target_include_directories(libtest PUBLIC ${CMAKE_CURRENT_LIST_DIR}/include)

add_subdirectory(bin)
add_subdirectory(lib)

include(cmake/include/dependency.cmake)
