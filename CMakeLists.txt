#!/usr/bin/cmake
cmake_minimum_required (VERSION 3.14...3.26.4 FATAL_ERROR)


include("./vcpkg-settings.cmake")
setup_vcpkg()


project(node-addon)


if (BUILD_VCPKG)
    add_subdirectory(toolsrc)
endif ()


# Import your CMake projects here...
add_subdirectory(projects/application)
