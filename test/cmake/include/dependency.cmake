#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
target_link_libraries(libtest PUBLIC vorlage::library)
if(ENABLE_COVERAGE)
  target_link_libraries(libtest PUBLIC scandium::coverage)
endif()
target_link_libraries(libtest PUBLIC Catch2::Catch2)
