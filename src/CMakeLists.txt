#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include(cmake/include/option.cmake)
include(cmake/include/process.option.cmake)
include(cmake/include/external.cmake)

add_library(libvorlage)
set_target_properties(libvorlage PROPERTIES OUTPUT_NAME vorlage)
add_library(vorlage::library ALIAS libvorlage)

target_include_directories(
  libvorlage
  PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}/include>
  $<INSTALL_INTERFACE:include>
  )

target_vanadium_cmake_codegen(
  libvorlage
  PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/codegen/cmake
  INSTALL
  )

add_subdirectory(lib)

include(cmake/include/dependency.cmake)
include(cmake/include/install.cmake)
