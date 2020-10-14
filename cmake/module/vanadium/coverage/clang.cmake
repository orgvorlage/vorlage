#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
string(APPEND CMAKE_CXX_FLAGS " -fprofile-instr-generate")
string(APPEND CMAKE_CXX_FLAGS " -fcoverage-mapping")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -fprofile-instr-generate")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -fcoverage-mapping")

set(VANADIUM_BINARY_PATH_ARRAY ${CMAKE_SYSTEM_PREFIX_PATH})
list(TRANSFORM VANADIUM_BINARY_PATH_ARRAY APPEND "/bin")

find_program(
  VANADIUM_LLVM_PROFDATA
  llvm-profdata
  NO_DEFAULT_PATH
  PATHS ${VANADIUM_BINARY_PATH_ARRAY}
  DOC "llvm-profdata executable"
  )

find_program(
  VANADIUM_LLVM_COV
  llvm-cov
  NO_DEFAULT_PATH
  PATHS ${VANADIUM_BINARY_PATH_ARRAY}
  DOC "llvm-cov executable"
  )


function(vanadium_start_coverage_group GROUP_NAME TARGET_NAME)
  add_custom_target(vanadium_${GROUP_NAME}_coverage)

  set(
    VANADIUM_TARGET_DIRECTORY
    "${VANADIUM_COVERAGE_OUTPUT_DIRECTORY}/${GROUP_NAME}"
    )

  set(
    VANADIUM_COVERAGE_${GROUP_NAME}_FILE_ARRAY
    PARENT_SCOPE
    )

  set(
    VANADIUM_COVERAGE_${GROUP_NAME}_TARGET
    ${TARGET_NAME}
    PARENT_SCOPE
    )

  set(
    VANADIUM_COVERAGE_${GROUP_NAME}_DIRECTORY
    ${VANADIUM_TARGET_DIRECTORY}
    PARENT_SCOPE
    )

  file(
    MAKE_DIRECTORY
    ${VANADIUM_TARGET_DIRECTORY}/raw
    )
endfunction()

function(vanadium_test_enable_coverage GROUP_NAME TEST_NAME)
  if(NOT TARGET vanadium_${GROUP_NAME}_coverage)
    message(FATAL_ERROR "Unknown Test Coverage Group")
  endif()
  set_tests_properties(
    ${TEST_NAME}
    PROPERTIES
    ENVIRONMENT
    LLVM_PROFILE_FILE=${VANADIUM_COVERAGE_${GROUP_NAME}_DIRECTORY}/raw/${TEST_NAME}.prof
    )

  list(
    APPEND
    VANADIUM_COVERAGE_${GROUP_NAME}_FILE_ARRAY
    "${VANADIUM_COVERAGE_${GROUP_NAME}_DIRECTORY}/raw/${TEST_NAME}.prof"
    )

  set(
    VANADIUM_COVERAGE_${GROUP_NAME}_FILE_ARRAY
    ${VANADIUM_COVERAGE_${GROUP_NAME}_FILE_ARRAY}
    PARENT_SCOPE
    )
endfunction()

function(postprocess_coverage GROUP_NAME)
  if(NOT TARGET vanadium_${GROUP_NAME}_coverage)
    message(FATAL_ERROR "Unknown Test Coverage Group")
  endif()
  set(TARGET_PATH $<TARGET_FILE:${VANADIUM_COVERAGE_${GROUP_NAME}_TARGET}>)

  add_custom_command(
    OUTPUT ${GROUP_NAME}.dat
    WORKING_DIRECTORY ${VANADIUM_COVERAGE_${GROUP_NAME}_DIRECTORY}
    COMMAND
    ${VANADIUM_LLVM_COV} show ${TARGET_PATH} -instr-profile=${GROUP_NAME}.profdata
    -Xdemangler=c++filt
    > ${GROUP_NAME}.dat
    DEPENDS ${GROUP_NAME}.profdata
    )

  add_custom_command(
    OUTPUT ${GROUP_NAME}.json
    WORKING_DIRECTORY ${VANADIUM_COVERAGE_${GROUP_NAME}_DIRECTORY}
    COMMAND
    ${VANADIUM_LLVM_COV} export ${TARGET_PATH} -instr-profile=${GROUP_NAME}.profdata
    -Xdemangler=c++filt > ${GROUP_NAME}.json
    DEPENDS ${GROUP_NAME}.profdata
    )

  add_custom_command(
    OUTPUT ${GROUP_NAME}.html
    WORKING_DIRECTORY ${VANADIUM_COVERAGE_${GROUP_NAME}_DIRECTORY}
    COMMAND ${VANADIUM_LLVM_COV} show ${TARGET_PATH}
    -instr-profile=${GROUP_NAME}.profdata
    -Xdemangler=c++filt --format=html -region-coverage-lt=100
    > ${GROUP_NAME}.html
    DEPENDS ${GROUP_NAME}.profdata
    )

  add_custom_target(
    vanadium_${GROUP_NAME}_coverage_files
    DEPENDS
    ${GROUP_NAME}.dat
    ${GROUP_NAME}.html
    ${GROUP_NAME}.json
    WORKING_DIRECTORY $<TARGET_FILE_DIR:${TARGET_NAME}>
    )

  add_dependencies(vanadium_${GROUP_NAME}_coverage vanadium_${GROUP_NAME}_coverage_files)
endfunction()

function(vanadium_end_coverage_group GROUP_NAME)
  set(TARGET_NAME ${VANADIUM_COVERAGE_${GROUP_NAME}_TARGET})
  set(GROUP_ARRAY ${VANADIUM_COVERAGE_${GROUP_NAME}_FILE_ARRAY} )

  add_custom_command(
    OUTPUT ${GROUP_NAME}.profdata
    WORKING_DIRECTORY ${VANADIUM_COVERAGE_${GROUP_NAME}_DIRECTORY}
    COMMAND
    ${VANADIUM_LLVM_PROFDATA} merge -sparse ${GROUP_ARRAY} -o ${GROUP_NAME}.profdata
    DEPENDS ${TARGET_NAME}
    )

  add_dependencies(vanadium_coverage vanadium_${GROUP_NAME}_coverage)
  postprocess_coverage(${GROUP_NAME})
endfunction()





