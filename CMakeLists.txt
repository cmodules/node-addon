#!/usr/bin/env cmake

# CMake requirements.
cmake_minimum_required (VERSION 3.9...3.26.3)

project(node-addon)

add_subdirectory(test/application)

add_subdirectory(toolsrc)
