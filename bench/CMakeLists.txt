#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
set(BENCHLIBNAME "libbench${PROJECT_NAME}")
add_library(${BENCHLIBNAME})
set_target_properties(${BENCHLIBNAME} PROPERTIES OUTPUT_NAME "bench${PROJECT_NAME}")
target_link_libraries(${BENCHLIBNAME} PUBLIC ${LIBNAME})
target_link_libraries(${BENCHLIBNAME} PUBLIC ${BASELIBNAME})

include(${PROJECT_SOURCE_DIR}/cmake/include/external.bench.cmake)

target_include_directories(
  ${BENCHLIBNAME} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/include
  )

add_subdirectory(bin)
add_subdirectory(lib)

include(${PROJECT_SOURCE_DIR}/cmake/include/dependency.bench.cmake)
