#!/usr/bin/env cmake

# CMake requirements.
cmake_minimum_required (VERSION 3.9...3.26.3)

macro (setup)

    if (${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
        message (FATAL_ERROR "Cannot configure into source tree - please choose a different binary directory!")
    endif ()

    set (ENV{VCPKG_ROOT} "${CMAKE_CURRENT_LIST_DIR}")
    set (ENV{VCPKG_DOWNLOADS} "${CMAKE_CURRENT_LIST_DIR}/downloads")
    set (ENV{VCPKG_DEFAULT_BINARY_CACHE} "${CMAKE_CURRENT_LIST_DIR}/archives")
    set (ENV{VCPKG_OVERLAY_PORTS} "")
    set (ENV{VCPKG_FORCE_SYSTEM_BINARIES} ON)
    # set (ENV{VCPKG_PREFER_SYSTEM_LIBS} ON) deprecated!! Use empty overlay ports instead...

    set (VCPKG_ROOT "$ENV{VCPKG_ROOT}" CACHE PATH "Path to vcpkg instance" FORCE)
    set (VCPKG_DOWNLOADS "$ENV{VCPKG_DOWNLOADS}" CACHE PATH "A path." FORCE)
    set (VCPKG_DEFAULT_BINARY_CACHE "$ENV{VCPKG_DEFAULT_BINARY_CACHE}" CACHE PATH "A path." FORCE)
    set (VCPKG_INSTALLED_DIR "${CMAKE_CURRENT_LIST_DIR}/installed" CACHE PATH "A path." FORCE)
    set (VCPKG_TRACE_FIND_PACKAGE ON CACHE PATH "A bool." FORCE)

    option (BUILD_SHARED_LIBS "Global flag to cause ``add_library()`` to create shared libraries by default, if on." ON)

    if (BUILD_SHARED_LIBS)
        set(VCPKG_CRT_LINKAGE "dynamic")
    else ()
        set(VCPKG_CRT_LINKAGE "static")
    endif()

    if (NOT CMAKE_TOOLCHAIN_FILE)
        if (WIN32)
            set (CMAKE_TOOLCHAIN_FILE "scripts/toolchains/windows.cmake")
        elseif (UNIX AND NOT APPLE)
            set (CMAKE_TOOLCHAIN_FILE "scripts/toolchains/linux.cmake")
        elseif (APPLE)
            set (CMAKE_TOOLCHAIN_FILE "scripts/toolchains/osx.cmake")
        endif ()
    endif ()

endmacro ()

setup()

project(node-addon)

add_subdirectory(toolsrc)

add_subdirectory(projects/application)
