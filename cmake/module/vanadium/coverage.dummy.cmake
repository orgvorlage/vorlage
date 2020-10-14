#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
if(TARGET vanadium_coverage)
  # This module has already been processed. Don't do it again.
  return()
endif()
add_custom_target(vanadium_coverage)

function(vanadium_start_coverage_group GROUP_NAME TARGET_NAME)
endfunction()

function(vanadium_test_enable_coverage GROUP_NAME TEST_NAME)
endfunction()

function(postprocess_coverage GROUP_NAME)
endfunction()

function(vanadium_end_coverage_group GROUP_NAME)
endfunction()
