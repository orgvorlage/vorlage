#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
  )

configure_package_config_file(
  ${PROJECT_SOURCE_DIR}/cmake/configure/${PROJECT_NAME}Config.cmake.in
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}
  )


install(
  TARGETS ${LIBNAME}
  EXPORT ${PROJECT_NAME}Target
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
  )

install(
  EXPORT ${PROJECT_NAME}Target
  FILE  ${PROJECT_NAME}Target.cmake
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake
  )

install(
  DIRECTORY ${PROJECT_SOURCE_DIR}/src/include
  DESTINATION  ${CMAKE_INSTALL_PREFIX}
  )

install(
  FILES
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  ${PROJECT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/cmake/
  )

install(
  FILES
  ${PROJECT_SOURCE_DIR}/license
  DESTINATION  ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/license
  )
