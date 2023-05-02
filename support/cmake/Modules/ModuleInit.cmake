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

  ${PROJECT_NAME}_VERSION_FILE
  ${PROJECT_NAME}_VERSION_FILE_MAJOR
  ${PROJECT_NAME}_VERSION_FILE_MINOR
  ${PROJECT_NAME}_VERSION_FILE_PATCH
  ${PROJECT_NAME}_VERSION_FILE_TWEAK

also defined, but not for general use are

::

  TBC...

#]=======================================================================]

option(INIT_MODULE TRUE "Create a NodeJS Addon API module")

# Create a NodeJS Addon API module
function(init_node_addon_api_module)

    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED True)

    # Set the host architecture to build with
    if (CMAKE_SIZEOF_VOID_P EQUAL 8)
        set(USE_X64 TRUE)
    else ()
        set(USE_X64 FALSE)
    endif ()

    # Single-threaded build-runs only for compatible behaviour
    set(CMAKE_BUILD_PARALLEL_LEVEL 1)
    set(CMAKE_INCLUDE_CURRENT_DIR OFF)
    set(USE_FOLDERS ON)
    set(BUILD_SHARED_LIBS ON)
    set(CMAKE_ENABLE_EXPORTS ON)
    set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
    set(CMAKE_INSTALL_MODE SYMLINK_OR_COPY)
    set(CMAKE_INSTALL_MESSAGE ALWAYS)
    set(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION ON)
    set(CPACK_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION ON)

endfunction()

if (INIT_MODULE)
    init_node_addon_api_module()
endif ()

function(enable_module target)

    if (MSVC)

        set(BMI ${CMAKE_CURRENT_BINARY_DIR}/${target}.ifc)

        target_compile_options(${target}
            PRIVATE
                /interface
                /ifcOutput
                ${BMI}
            INTERFACE
                /reference
                ${target}=${BMI}
        )

    endif ()

    set_target_properties(${target}
        PROPERTIES
            ADDITIONAL_CLEAN_FILES ${BMI}
    )

    set_source_files_properties(${BMI}
        PROPERTIES
            GENERATED ON
    )

endfunction()

# function(add_node_defines)
#   add_compile_definitions(UNICODE)
#   add_compile_definitions(_UNICODE)

#   # Host handling:
#   if(WIN32)
#     add_compile_definitions(WINDOWS=1)
#     message(STATUS "Setting Compile Definition WINDOWS=1")
#   endif ()

#   if (UNIX AND NOT APPLE)
#     add_compile_definitions(LINUX=1)
#     message(STATUS "Setting Compile Definition LINUX=1")
#   endif ()

#   if (APPLE)
#     add_compile_definitions(APPLE=1)
#     message(STATUS "Setting Compile Definition APPLE=1")
#   endif ()

#   # Debug definitions:
#   if (${CMAKE_BUILD_TYPE} MATCHES Debug OR RelWithDebInfo)
#     add_compile_definitions(_DEBUG=1)
#     message(STATUS "Setting Compile Definition _DEBUG=1")
#   else ()
#     add_compile_definitions(NDEBUG=1)
#     message(STATUS "Setting Compile Definition NDEBUG=1")
#   endif ()

#   # Set the require pre-processor defines for NAPI_VERSION and BUILDING_NODE_EXTENSION
#   if (WIN32)
#     set(CMAKE_CXX_FLAGS -DNAPI_VERSION=8 -DBUILDING_NODE_EXTENSION)
#     # add_compile_definitions(NAPI_VERSION=${napi_build_version})
#     # add_compile_definitions(BUILDING_NODE_EXTENSION)
#     target_compile_definitions(${PROJECT_NAME}
#       PUBLIC
#         -DNAPI_VERSION=8
#         -DBUILDING_NODE_EXTENSION
#     )
#     target_link_options(${PROJECT_NAME}
#       PUBLIC
#         /DELAYLOAD:NODE.EXE
#     )
#     set(CMAKE_SHARED_LINKER_FLAGS /DELAYLOAD:NODE.EXE)
#   endif ()

#   if (UNIX AND NOT APPLE)
#     set(CMAKE_CXX_FLAGS -DNAPI_VERSION=8 -DBUILDING_NODE_EXTENSION)
#     # add_compile_definitions(NAPI_VERSION=${napi_build_version})
#     # add_compile_definitions(BUILDING_NODE_EXTENSION)
#     target_compile_definitions(${PROJECT_NAME}
#       PUBLIC
#         -DNAPI_VERSION=8
#         -DBUILDING_NODE_EXTENSION
#     )
#   endif ()

#   if (APPLE)
#     set(CMAKE_CXX_FLAGS -DNAPI_VERSION=8 -DBUILDING_NODE_EXTENSION -D_DARWIN_USE_64_BIT_INODE=1 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 ${CMAKE_CXX_FLAGS})
#     # add_compile_definitions(NAPI_VERSION=${napi_build_version})
#     # add_compile_definitions(BUILDING_NODE_EXTENSION)
#     # add_compile_definitions(_DARWIN_USE_64_BIT_INODE=1)
#     # add_compile_definitions(_LARGEFILE_SOURCE)
#     # add_compile_definitions(_FILE_OFFSET_BITS=64)
#     set(CMAKE_SHARED_LINKER_FLAGS dynamic_lookup)
#     target_compile_definitions(${PROJECT_NAME}
#       PUBLIC
#         -DNAPI_VERSION=8
#         -DBUILDING_NODE_EXTENSION
#         -D_DARWIN_USE_64_BIT_INODE=1
#         -D_LARGEFILE_SOURCE
#         -D_FILE_OFFSET_BITS=64
#     )
#     target_link_options(${PROJECT_NAME}
#       PUBLIC
#         dynamic_lookup
#     )
#   endif ()

# endfunction()
