#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
target_link_libraries(${TESTLIBNAME} PUBLIC Catch2::Catch2)
target_link_libraries(${TESTLIBNAME} PUBLIC vanadium::filesystem)
