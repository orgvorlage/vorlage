#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include_guard(GLOBAL)
find_package(Doxygen REQUIRED dot)
if(DOXYGEN_FOUND)
  set(DOXYGEN_ALL_TARGET ALL)
  set(DOXYFILE_IN ${PROJECT_SOURCE_DIR}/cmake/configure/doxyfile.in)
  file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/vanadium/configure/)
  set(DOXYFILE ${PROJECT_BINARY_DIR}/vanadium/configure/Doxyfile)
  message(VERBOSE "Configuring Doxygen Documentation Generator")
  configure_file(${DOXYFILE_IN} ${DOXYFILE} @ONLY)

  file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/vanadium/doxygen)

  add_custom_target(vanadium_doxygen ${DOXYGEN_ALL_TARGET}
    COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYFILE}
    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/vanadium/doxygen
    COMMENT "Generating API Documentation with Doxygen"
    VERBATIM
    )
else ()
  message(FATAL_ERROR "Doxygen not found.")
endif()
