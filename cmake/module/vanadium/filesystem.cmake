#-------------------------------------------------------------------------------
# SPDX-License-Identifier: "Apache-2.0 OR MIT"
# Copyright (C) 2020, Jayesh Badwaik <jayesh@badwaik.in>
#-------------------------------------------------------------------------------
if(TARGET vanadium::filesystem)
  return()
endif()

include(CMakePushCheckState)
include(CheckIncludeFileCXX)
include(CheckCXXSourceCompiles)

cmake_push_check_state()
  set(CMAKE_REQUIRED_QUIET TRUE)
  check_include_file_cxx("filesystem" _VANADIUM_FILESYSTEM_HAVE_HEADER)
  mark_as_advanced(_VANADIUM_FILESYSTEM_HAVE_HEADER)

  if(_VANADIUM_FILESYSTEM_HAVE_HEADER)
    set(find_experimental FALSE)
  else()
    set(find_experimental TRUE)
  endif()

  if(find_experimental)
    check_include_file_cxx(
      "experimental/filesystem"
      _VANADIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER
      )
    mark_as_advanced(_VANADIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER)
  endif()

  if(_VANADIUM_FILESYSTEM_HAVE_HEADER)
    set(_have_fs TRUE)
    set(_fs_header filesystem)
    set(_fs_namespace std::filesystem)
  elseif(_VANADIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER)
    set(_have_fs TRUE)
    set(_fs_header experimental/filesystem)
    set(_fs_namespace std::experimental::filesystem)
  else()
    set(_have_fs FALSE)
  endif()

  set(VANADIUM_FILESYSTEM_IS_EXPERIMENTAL
    ${_VANADIUM_FILESYSTEM_HAVE_EXPERIMENTAL_HEADER}
    CACHE BOOL "TRUE if we have C++ filesystem experimental header"
    )

  set(VANADIUM_FILESYSTEM_HAVE_FS
    ${_have_fs} CACHE BOOL "TRUE if we have the C++ filesystem headers"
    )

  set(VANADIUM_FILESYSTEM_HEADER
    ${_fs_header}
    CACHE STRING "The header that should be included to obtain the filesystem APIs"
    )

  set(VANADIUM_FILESYSTEM_NAMESPACE
    ${_fs_namespace}
    CACHE STRING "The C++ namespace that contains the filesystem APIs"
    )

  set(_found FALSE)

  if(VANADIUM_FILESYSTEM_HAVE_FS)
    # We have some filesystem library available. Do link checks
    string(CONFIGURE [[
      #include <@VANADIUM_FILESYSTEM_HEADER@>

      int main() {
      auto cwd = @VANADIUM_FILESYSTEM_NAMESPACE@::current_path();
      return static_cast<int>(cwd.string().size());
      }
      ]] code @ONLY)

    # Try to compile a simple filesystem program without any linker flags
    check_cxx_source_compiles("${code}" VANADIUM_FILESYSTEM_NO_LINK_NEEDED)

    set(can_link ${VANADIUM_FILESYSTEM_NO_LINK_NEEDED})

    if(NOT VANADIUM_FILESYSTEM_NO_LINK_NEEDED)
      set(prev_libraries ${CMAKE_REQUIRED_LIBRARIES})
      # Add the libstdc++ flag
      set(CMAKE_REQUIRED_LIBRARIES ${prev_libraries} -lstdc++fs)
      check_cxx_source_compiles("${code}" VANADIUM_FILESYSTEM_STDCPPFS_NEEDED)
      set(can_link ${VANADIUM_FILESYSTEM_STDCPPFS_NEEDED})
      if(NOT VANADIUM_FILESYSTEM_STDCPPFS_NEEDED)
        # Try the libc++ flag
        set(CMAKE_REQUIRED_LIBRARIES ${prev_libraries} -lc++fs)
        check_cxx_source_compiles("${code}" VANADIUM_FILESYSTEM_CPPFS_NEEDED)
        set(can_link ${VANADIUM_FILESYSTEM_CPPFS_NEEDED})
      endif()
    endif()

    if(can_link)
      add_library(vanadium::filesystem INTERFACE IMPORTED)
      set(_found TRUE)

      if(VANADIUM_FILESYSTEM_NO_LINK_NEEDED)
        # Nothing to add...
      elseif(VANADIUM_FILESYSTEM_STDCPPFS_NEEDED)
        target_link_libraries(vanadium::filesystem INTERFACE -lstdc++fs)
      elseif(VANADIUM_FILESYSTEM_CPPFS_NEEDED)
        target_link_libraries(vanadium::filesystem INTERFACE -lc++fs)
      endif()
    endif()
  endif()
cmake_pop_check_state()

set(Vanadium::Filesystem_FOUND
  ${_found}
  CACHE BOOL "TRUE if we can compile and link a program using vanadium::filesystem"
  FORCE
  )

if(NOT Vanadium::Filesystem_FOUND)
  message(FATAL_ERROR "Cannot compile simple program using vanadium::filesystem.")
endif()

