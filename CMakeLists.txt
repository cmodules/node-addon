#!/usr/bin/cmake
cmake_minimum_required (VERSION 3.14...3.26 FATAL_ERROR)

include("./vcpkg-settings.cmake")
setup_vcpkg()

project(node-addon)
include ("./projects/cmrc/CMakeRC.cmake")
add_subdirectory(projects/cmrc/tests)
add_subdirectory(projects/fmt)
# add_subdirectory(toolsrc)
# add_subdirectory(projects/resources)

# Import your CMake projects here...
add_subdirectory(projects/application)
# "${CMAKE_BINARY_DIR}/${VCPKG_TARGET_TRIPLET}"
