#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
add_executable(vorlage.b vorlage.b.cpp)
target_link_libraries(vorlage.b PUBLIC ${BENCHLIBNAME})
file(MAKE_DIRECTORY ${OUTPUT_DATA_ABSPATH}/bench/vorlage)
add_test(
  NAME vorlage.b
  COMMAND vorlage.b
    --benchmark_format=json
    --benchmark_out=${OUTPUT_DATA_ABSPATH}/bench/vorlage/info.json
    --input-data ${INPUT_DATA_ABSPATH}
    --output-data ${OUTPUT_DATA_ABSPATH}
  )
set_property(TEST vorlage.b PROPERTY LABELS UnitBenchmark)
add_subdirectory(vorlage)
