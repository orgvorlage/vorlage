#------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#------------------------------------------------------------------------------

# Install Targets and Header Files
install(TARGETS libvorlage EXPORT vorlageTarget)

install(
  DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include
  DESTINATION  ${CMAKE_INSTALL_PREFIX}
  )
