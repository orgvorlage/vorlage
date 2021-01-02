#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------
################################################################################
# Process Build Features Arguments
################################################################################
foreach(BUILD_FEATURE ${BUILD_FEATURE_LIST})
  if(NOT BUILD_FEATURE IN_LIST BUILD_FEATURE_FULL_LIST)
    message(FATAL_ERROR "
    Unknown Build Feature: ${BUILD_FEATURE}
    Supported Build Features: ${BUILD_FEATURE_FULL_LIST}
    ")
  endif()
endforeach()

if("None" IN_LIST BUILD_FEATURE_LIST)
  list(LENGTH BUILD_FEATURE_LIST BUILD_FEATURE_LIST_LENGTH)
  if(NOT ${BUILD_FEATURE_LIST_LENGTH} EQUAL 1)
    message(FATAL_ERROR "
    Build Features Specified: ${BUILD_FEATURE_LIST}
    No other build feature can be specified along with None.
    ")
  endif()
endif()

if("All" IN_LIST BUILD_FEATURE_LIST)
  list(LENGTH BUILD_FEATURE_LIST BUILD_FEATURE_LIST_LENGTH)
  if(NOT ${BUILD_FEATURE_LIST_LENGTH} EQUAL 1)
    message(FATAL_ERROR "
    Build Features Specified: ${BUILD_FEATURE_LIST}
    No other build feature can be specified along with All.
    ")
  endif()
endif()

################################################################################
# Process Debug Mode Arguments
################################################################################
foreach(DEBUG_MODE ${DEBUG_MODE_LIST})
  if(NOT DEBUG_MODE IN_LIST DEBUG_MODE_FULL_LIST)
    message(FATAL_ERROR "
    Unknown Debug Mode: ${DEBUG_MODE}
    Supported Debug Modes: ${DEBUG_MODE_FULL_LIST}
    ")
  endif()
endforeach()

if("None" IN_LIST DEBUG_MODE_LIST)
  list(LENGTH DEBUG_MODE_LIST DEBUG_MODE_LIST_LENGTH)
  if(NOT ${DEBUG_MODE_LIST_LENGTH} EQUAL 1)
    message(FATAL_ERROR "
    Debug Modes Specified: ${DEBUG_MODE_LIST}
    No other debug mode can be specified along with None.
    ")
  endif()
endif()

if("All" IN_LIST DEBUG_MODE_LIST)
  list(LENGTH DEBUG_MODE_LIST DEBUG_MODE_LIST_LENGTH)
  if(NOT ${DEBUG_MODE_LIST_LENGTH} EQUAL 1)
    message(FATAL_ERROR "
    Debug Modes Specified: ${DEBUG_MODE_LIST}
    No other debug mode can be specified along with All.
    ")
  endif()
endif()


