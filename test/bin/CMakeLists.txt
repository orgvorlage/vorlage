#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
###############################################################################
# base.t
###############################################################################
add_executable(base.t base.t.cpp)
target_link_libraries(base.t PUBLIC ${TESTLIBNAME})
if(ENABLE_COVERAGE)
  vanadium_start_coverage_group(base.t.all base.t)
endif()
add_test(
  NAME base.t
  COMMAND base.t
  --input-data  input_data
  --output-data output_data
  )
set_property(TEST base.t PROPERTY LABELS UnitTest)
add_subdirectory(base)
if(ENABLE_COVERAGE)
  vanadium_test_enable_coverage(base.t.all base.t)
  vanadium_end_coverage_group(base.t.all)
endif()


###############################################################################
# test.t
###############################################################################
add_executable(test.t test.t.cpp)
target_link_libraries(test.t PUBLIC ${TESTLIBNAME})
if(ENABLE_COVERAGE)
  vanadium_start_coverage_group(test.t.all test.t)
endif()
add_test(
  NAME test.t
  COMMAND test.t
  --input-data ${INPUT_DATA_ABSPATH}
  --output-data ${OUTPUT_DATA_ABSPATH}
  )
set_property(TEST test.t PROPERTY LABELS UnitTest)
add_subdirectory(test)
if(ENABLE_COVERAGE)
  vanadium_test_enable_coverage(test.t.all test.t)
  vanadium_end_coverage_group(test.t.all)
endif()

###############################################################################
# unit.t
###############################################################################
add_executable(unit.t unit.t.cpp)
target_link_libraries(unit.t PUBLIC ${TESTLIBNAME})

if(ENABLE_COVERAGE)
  vanadium_start_coverage_group(unit.t.all unit.t)
endif()

add_test(
  NAME unit.t
  COMMAND unit.t
  --input-data ${INPUT_DATA_ABSPATH}
  --output-data ${OUTPUT_DATA_ABSPATH}
  )
set_property(TEST unit.t PROPERTY LABELS UnitTest)

add_subdirectory(unit)
if(ENABLE_COVERAGE)
  vanadium_test_enable_coverage(unit.t.all unit.t)
  vanadium_end_coverage_group(unit.t.all)
endif()


