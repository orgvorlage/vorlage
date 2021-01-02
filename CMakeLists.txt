#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.19)
project(
  vorlage
  VERSION 0.0.0.0
  DESCRIPTION "vorlage"
  LANGUAGES CXX
  HOMEPAGE_URL "https://gitlab.version.fz-juelich.de/orgvorlage/vorlage"
  )
include(cmake/include/system.cmake)

include(cmake/include/option.cmake)
include(cmake/include/process.option.cmake)

add_subdirectory(src)

if(BUILD_TESTING)
  add_subdirectory(test)
endif()
