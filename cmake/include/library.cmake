#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
set(LIBNAME "lib${PROJECT_NAME}")
add_library(${LIBNAME})
set_target_properties(${LIBNAME} PROPERTIES OUTPUT_NAME ${PROJECT_NAME})
add_library(${PROJECT_NAME}::${LIBNAME} ALIAS ${LIBNAME})
