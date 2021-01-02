#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------

include(GNUInstallDirs)

# Write Project Version Information
include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  ${PROJECT_BINARY_DIR}/vorlageConfigVersion.cmake
  VERSION ${CMAKE_PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
  )

install(
  FILES
  ${PROJECT_BINARY_DIR}/vorlageConfig.cmake
  ${PROJECT_BINARY_DIR}/vorlageConfigVersion.cmake
  DESTINATION ${CMAKE_INSTALL_DATADIR}/vorlage/cmake/
  )

# Generate vorlageConfig.cmake file
configure_package_config_file(
  ${PROJECT_SOURCE_DIR}/cmake/configure/vorlageConfig.cmake.in
  ${PROJECT_BINARY_DIR}/vorlageConfig.cmake
  INSTALL_DESTINATION ${CMAKE_INSTALL_DATADIR}/vorlage
  )


install(
  EXPORT vorlageTarget
  FILE  vorlageTarget.cmake
  NAMESPACE vorlage::
  DESTINATION ${CMAKE_INSTALL_DATADIR}/vorlage/cmake
  )


# Install License
install(
  FILES
  ${PROJECT_SOURCE_DIR}/license
  DESTINATION  ${CMAKE_INSTALL_DATADIR}/licenses/vorlage/
  )

