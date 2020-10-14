#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include(${PROJECT_SOURCE_DIR}/cmake/include/external.base.cmake)
target_include_directories(
  ${BASELIBNAME}
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>
  $<INSTALL_INTERFACE:include>
  )

add_subdirectory(lib)
include(${PROJECT_SOURCE_DIR}/cmake/include/dependency.base.cmake)
