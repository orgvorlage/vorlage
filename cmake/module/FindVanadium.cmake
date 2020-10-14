#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include(CMakePushCheckState)
cmake_push_check_state()

set(CMAKE_REQUIRED_QUIET ${Vanadium_FIND_QUIETLY})
set(want_components ${Vanadium_FIND_COMPONENTS})

set(extra_components ${want_components})
list(REMOVE_ITEM extra_components Codegen Coverage Doxygen Filesystem)

foreach(component IN LISTS extra_components)
  message(WARNING "Extraneous find_package component for Vanadium: ${component}")
endforeach()

if("Codegen" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/vanadium/codegen.cmake)
endif()

if("Coverage" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/vanadium/coverage.cmake)
endif()

if("Doxygen" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/vanadium/doxygen.cmake)
endif()

if("Filesystem" IN_LIST want_components)
  include(${CMAKE_CURRENT_LIST_DIR}/vanadium/filesystem.cmake)
endif()
cmake_pop_check_state()
