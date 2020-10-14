#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
set(TESTLIBNAME "libtest${PROJECT_NAME}")
add_library(${TESTLIBNAME})
set_target_properties(${TESTLIBNAME} PROPERTIES OUTPUT_NAME "test${PROJECT_NAME}")
target_link_libraries(${TESTLIBNAME} PUBLIC ${LIBNAME})
target_link_libraries(${TESTLIBNAME} PUBLIC ${BASELIBNAME})

include(${PROJECT_SOURCE_DIR}/cmake/include/external.test.cmake)

target_include_directories(
  ${TESTLIBNAME} PUBLIC
  ${CMAKE_CURRENT_LIST_DIR}/include
  )

add_subdirectory(bin)
add_subdirectory(lib)

include(${PROJECT_SOURCE_DIR}/cmake/include/dependency.test.cmake)
