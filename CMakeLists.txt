#!/usr/bin/env cmake

# CMake requirements.
cmake_minimum_required (VERSION 3.9...3.26.3)

if (${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
    message (FATAL_ERROR "Cannot configure into source tree - please choose a different binary directory!")
endif ()

project(node-addon)

add_subdirectory(toolsrc)

add_subdirectory(projects/application)
