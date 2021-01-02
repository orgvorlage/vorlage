#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------
if(ENABLE_COVERAGE)
  target_link_libraries(libvorlage PUBLIC scandium::coverage)
endif()
