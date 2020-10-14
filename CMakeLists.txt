#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
cmake_minimum_required(VERSION 3.12)

project(
  vorlage
  VERSION 0.0.0.0
  DESCRIPTION "vorlage"
  LANGUAGES CXX
  HOMEPAGE_URL "https://gitlab.version.fz-juelich.de/orgvorlage/vorlage"
  )
list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/module")
include(GNUInstallDirs)

set(CMAKE_DEBUG_POSTFIX -debug)
enable_testing()

include(cmake/include/option.cmake)

include(cmake/include/library.cmake)
include(cmake/include/external.cmake)
add_subdirectory(src)
include(cmake/include/dependency.cmake)

if(BUILD_BENCHMARKING OR BUILD_TESTING)
  include(cmake/include/base.cmake)
  add_subdirectory(base)
endif()

if(BUILD_TESTING)
  add_subdirectory(test)
endif()

if(BUILD_BENCHMARKING)
  add_subdirectory(bench)
endif()

include(cmake/include/install.cmake)
