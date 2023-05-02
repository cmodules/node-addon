#!/usr/bin/env cmake

# @StoneyDSP/UseVcpkg.cmake - a CMake module for activating vcpkg package manager (MIT 2023)

# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
UseVcpkg
--------

Find the native vcpkg includes, sources, binaries, and libraries

This module defines

::

  VCPKG_DOWNLOAD_DIR
  VCPKG_INSTALLED_DIR
  VCPKG_FOUND, If false, do not try to use CMakeJs.

also defined, but not for general use are

::

#]=======================================================================]

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

if (NOT DEFINED USE_VCPKG)
    set(USE_VCPKG ON CACHE BOOL "Use vcpkg for C++ packages")
    set(NEW_VCPKG_CONFIGURATION OFF CACHE BOOL "Use custom vcpkg configuration for C++ packages (ideal for forks)")
endif ()

if (USE_VCPKG)

    # create vcpkg manifest file
    message(STATUS "    Creating vcpkg manifest...")
    configure_file(
        ${PROJECT_SOURCE_DIR}/support/vcpkg/vcpkg.in.json
        ${PROJECT_BINARY_DIR}/vcpkg.json
    )

    if (NEW_VCPKG_CONFIGURATION)

        # # create vcpkg configuration file
        message(STATUS "    Creating vcpkg configuration...")
        configure_file(
            ${PROJECT_SOURCE_DIR}/support/vcpkg/vcpkg-configuration.in.json
            ${PROJECT_BINARY_DIR}/vcpkg-configuration.json
        )

        # create vcpkg portfile
        message(STATUS "    Creating vcpkg portfile...")
        configure_file(
            ${PROJECT_SOURCE_DIR}/support/vcpkg/portfile.in.cmake
            ${PROJECT_BINARY_DIR}/${PROJECT_NAME_LOWER}-portfile.cmake
        )

    endif ()

endif ()
