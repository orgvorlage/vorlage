#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------
function(vorlage_add_unit_test COVERAGE_GROUP TEST_NAME SOURCE_FILE)
  add_executable(${TEST_NAME} ${SOURCE_FILE})
  target_link_libraries(${TEST_NAME} PUBLIC libtest)
  add_test(
    NAME ${TEST_NAME}
    COMMAND ${TEST_NAME}
    --input-data ${TEST_INPUT_DATA_ABSPATH}
    --output-data ${TEST_OUTPUT_DATA_ABSPATH}
    )
  set_property(TEST ${TEST_NAME} PROPERTY LABELS UnitTest)
  scandium_coverage_register_test(${COVERAGE_GROUP} ${TEST_NAME} ${TEST_NAME})
endfunction()
