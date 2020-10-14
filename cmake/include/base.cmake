#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
set(BASELIBNAME "libbase${PROJECT_NAME}")
add_library(${BASELIBNAME})
set_target_properties(${BASELIBNAME} PROPERTIES OUTPUT_NAME base${PROJECT_NAME})
