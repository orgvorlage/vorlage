#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
function(target_vanadium_cmake_codegen TARGETNAME LINK_TYPE INDIR INSTALL_FLAG )
  file(RELATIVE_PATH REL_INDIR ${PROJECT_SOURCE_DIR} ${INDIR})
  set(SRC_OUTDIR "${PROJECT_BINARY_DIR}/vanadium/codegen/cmake/${REL_INDIR}/lib")
  set(INC_OUTDIR "${PROJECT_BINARY_DIR}/vanadium/codegen/cmake/${REL_INDIR}/include")
  file(GLOB_RECURSE CMAKE_HEADER_LIST "*.hpp.cmake.codegen")
  file(GLOB_RECURSE CMAKE_SOURCE_LIST "*.cpp.cmake.codegen")

  file(MAKE_DIRECTORY ${SRC_OUTDIR})
  file(MAKE_DIRECTORY ${INC_OUTDIR})

  target_include_directories(
    ${TARGETNAME}
    ${LINK_TYPE}
    $<BUILD_INTERFACE:${INC_OUTDIR}>
    $<INSTALL_INTERFACE:include>
    )

  foreach(INFILE ${CMAKE_SOURCE_LIST})
    file(RELATIVE_PATH REL_INFILE ${INDIR} ${INFILE})
    string(REPLACE ".cmake.in" "" REL_OUTFILE ${REL_INFILE})
    set(OUTFILE "${SRC_OUTDIR}/${REL_OUTFILE}")
    configure_file(${INFILE} ${OUTFILE} @ONLY)
    target_sources(${TARGETNAME} PRIVATE ${OUTFILE})
  endforeach()

  foreach(INFILE ${CMAKE_HEADER_LIST})
    file(RELATIVE_PATH REL_INFILE ${INDIR} ${INFILE})
    string(REPLACE ".cmake.in" "" REL_OUTFILE ${REL_INFILE})
    set(OUTFILE "${INC_OUTDIR}/${REL_OUTFILE}")
    configure_file(${INFILE} ${OUTFILE} @ONLY)
  endforeach()

  # Install Generated Headers
  if(INSTALL_FLAG STREQUAL "INSTALL_YES")
    install(
      DIRECTORY ${INC_OUTDIR}
      DESTINATION  ${CMAKE_INSTALL_PREFIX}
      )
  elseif(INSTALL_FLAG STREQUAL "INSTALL_NO")
  else()
    message(FATAL_ERROR "Incorrect Arguments Passed")
  endif()
endfunction()
