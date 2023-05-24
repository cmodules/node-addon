#!/usr/bin/env cmake

# StoneyDSP/cmodule - a public template for C++ modules for NodeJS (MIT 2023)

# CMake requirements.
cmake_minimum_required (VERSION 3.9...3.26.3)

# Cmake-js requirements
cmake_policy (SET CMP0011 NEW)
cmake_policy (SET CMP0091 NEW)
cmake_policy (SET CMP0042 NEW)

# Fallback for using newer policies on CMake < 3.12.
if (${CMAKE_VERSION} VERSION_LESS 3.12)

    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})

endif ()

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

# Locate the file directory
set (TOOLCHAIN_DIR "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains" CACHE STRING "Location of available toolchain files for building." FORCE)

# Glob all files with .cmake extensions in the dir and pass them to a shared VARIABLE
file (GLOB TOOLCHAIN_FILES RELATIVE ${TOOLCHAIN_DIR} "*cmake")

# Glob each file in the dir and pass them to a unique VARIABLE
file (READ "${TOOLCHAIN_DIR}/windows.cmake" TOOLCHAIN_FILE_WINDOWS)
file (READ "${TOOLCHAIN_DIR}/linux.cmake"   TOOLCHAIN_FILE_LINUX)
file (READ "${TOOLCHAIN_DIR}/osx.cmake"     TOOLCHAIN_FILE_OSX)
file (READ "${TOOLCHAIN_DIR}/ios.cmake"     TOOLCHAIN_FILE_IOS)
file (READ "${TOOLCHAIN_DIR}/android.cmake" TOOLCHAIN_FILE_ANDROID)
file (READ "${TOOLCHAIN_DIR}/mingw.cmake"   TOOLCHAIN_FILE_MINGW)
file (READ "${TOOLCHAIN_DIR}/freebsd.cmake" TOOLCHAIN_FILE_FREEBSD)
file (READ "${TOOLCHAIN_DIR}/openbsd.cmake" TOOLCHAIN_FILE_OPENBSD)
file (READ "${TOOLCHAIN_DIR}/uwp.cmake"     TOOLCHAIN_FILE_UWP)
file (READ "${TOOLCHAIN_DIR}/xbox.cmake"    TOOLCHAIN_FILE_XBOX)

source_group("Toolchain Files" FILES ${TOOLCHAIN_FILES})


# ====================================
#   ___        _   _
#  / _ \ _ __ | |_(_) ___  _ __  ___
# | | | | '_ \| __| |/ _ \| '_ \/ __|
# | |_| | |_) | |_| | (_) | | | \__ \
#  \___/| .__/ \__|_|\___/|_| |_|___/
#       |_|
#
# Options that control generation of various targets.

option (${PROJECT_NAME_UPPER}_ASAN_ENABLED      "Build with Address Sanitizer"                              OFF)
option (${PROJECT_NAME_UPPER}_PEDANTIC          "Enable extra warnings and expensive tests."                ON)
option (${PROJECT_NAME_UPPER}_WERROR            "Halt the compilation with an error on compiler warnings."  OFF)
option (${PROJECT_NAME_UPPER}_INSTALL           "Generate the install target."                              ON)
option (${PROJECT_NAME_UPPER}_VCPKG             "Integrate vcpkg for C++ packages."                         OFF)
option (${PROJECT_NAME_UPPER}_TEST              "Generate the test target."                                 ON)
option (${PROJECT_NAME_UPPER}_INC_NODE_HEADERS  "Include Node API headers in build project"                 OFF)
option (${PROJECT_NAME_UPPER}_MODULE            "Build a C++ module instead of a NodeJS library."           OFF)
option (USE_VCPKG "Enable vcpkg for C/C++ package dependency resolution (recommended)." ON)


if (USE_VCPKG)

    if(NOT CMAKE_BUILD_TYPE)
        # message(FATAL_ERROR "CMAKE_BUILD_TYPE is required to be defined")

        set(CMAKE_BUILD_TYPE "Debug")

    else()
        # string(TOUPPER "${CMAKE_BUILD_TYPE}" VCPKG_CONFIGS)
    endif()

    set (CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/.vcpkg/scripts/buildsystems/vcpkg.cmake")

    # obvs needs a fix...
    set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/.vcpkg/scripts/toolchains/windows.cmake")

    set (VCPKG_DOWNLOADS "${CMAKE_CURRENT_LIST_DIR}/downloads")

    set (VCPKG_INSTALLED_DIR "${CMAKE_CURRENT_LIST_DIR}/build")


    set (VCPKG_CRT_LINKAGE "dynamic")

    set (VCPKG_ROOT "${CMAKE_CURRENT_LIST_DIR}/.vcpkg")

    set (VCPKG_MANIFEST_FILE "${CMAKE_CURRENT_LIST_DIR}/vcpkg.json")

    #set (VCPKG_HOST_TRIPLET "<triplet>" CACHE STRING "Can be overridden via VCPKG_DEFAULT_HOST_TRIPLET environment variable" FORCE)


    # If the current context is cross-compiling (TARGET_TRIPLET is not HOST_TRIPLET),
    # VCPKG_CROSSCOMPILING will be set to a truthy value.

    set (CMAKE_CROSSCOMPILING ${VCPKG_CROSSCOMPILING} CACHE STRING "Intended to indicate whether CMake is cross compiling, but note limitations discussed below." FORCE)

    if (VCPKG_CROSSCOMPILING)

        message (STATUS "    This is a native build")

        # If mattempting to cross-compile a host-only port, throw an error
        message(FATAL_ERROR "This is a host only port!")

    else ()

        message (STATUS "    This is a cross build")

    endif ()

endif ()

# Import some custom helpers to set up CMake for NodeJS development
set(CMAKE_MODULE_PATH

    ${CMAKE_CURRENT_LIST_DIR}/support/cmake/Modules
    ${CMAKE_MODULE_PATH}

)

include (ModuleInit)
include (Stringify)
include (CheckCXXSourceCompiles)
include (CheckCXXCompilerFlag)


if (NOT DEFINED NODE_ADDON_API_INCLUDED)

    set (USE_VCPKG ON)

    set (NODE_ADDON_API_INCLUDED TRUE CACHE BOOL "Node Addon API included in project (use as an include guard)")

    find_program (NODE_EXECUTABLE

        NAMES "node" "node.exe"
        PATHS "$ENV{PATH}" "$ENV{ProgramFiles}/nodejs"
        DOC "NodeJs executable binary"
        REGISTRY_VIEW HOST
        REQUIRED

    )

    if (NODE_EXECUTABLE)

        message(STATUS "    NODE_EXECUTABLE = ${NODE_EXECUTABLE}")

    else ()

        message(FATAL_ERROR "    NodeJS system installation not found! Please install NodeJS and try again.")

    endif()


    find_program (NPM_EXECUTABLE

        NAMES "npm" "npm.exe"
        PATHS "$ENV{PATH}" "$ENV{ProgramFiles}/npm"
        DOC "npm executable binary"
        REGISTRY_VIEW HOST
        REQUIRED

    )

    if (NPM_EXECUTABLE)

        message(STATUS "    NPM_EXECUTABLE = ${NPM_EXECUTABLE}")

    else ()

        message(FATAL_ERROR "    npm system installation not found! Please install NodeJS and try again.")

    endif()


    find_program (NPX_EXECUTABLE

        NAMES "npx" "npx.exe"
        PATHS "$ENV{PATH}" "$ENV{ProgramFiles}/nodejs"
        DOC "npx package executable binary"
        REGISTRY_VIEW HOST
        REQUIRED

    )

    if (NPX_EXECUTABLE)

        message(STATUS "    NPX_EXECUTABLE = ${NPX_EXECUTABLE}")

    else ()

        message(FATAL_ERROR "    npx system installation not found! Please install NodeJS and try again.")

    endif()

    # List of executable commands
    set (NODE_COMMAND "${NODE_EXECUTABLE}" CACHE STRING "Call NodeJS commands from here." FORCE)

    # List of NodeJS commands
    set (NODE_VERSION_COMMAND ${NODE_COMMAND} --version CACHE STRING "print Node.js version" FORCE)
    set (NODE_HELP_COMMAND ${NODE_COMMAND} --help CACHE STRING "print node command line options" FORCE)
    set (NODE_CHECK_COMMAND ${NODE_COMMAND}--check CACHE STRING "syntax check script without executing (requires arguments)" FORCE)
    set (NODE_EVAL_COMMAND ${NODE_COMMAND} --eval CACHE STRING "evaluate script (requires arguments)" FORCE)
    set (NODE_PRINT_COMMAND ${NODE_COMMAND} --print CACHE STRING "evaluate script and print result (requires arguments)" FORCE)
    set (NODE_REQUIRE_COMMAND ${NODE_COMMAND} --require CACHE STRING "module to preload (option can be repeated) (requires arguments)" FORCE)
    set (REPL_COMMAND ${NODE_COMMAND} --interactive CACHE STRING "always enter the REPL even if stdin does not appear to be a terminal" FORCE)

    execute_process(
        COMMAND ${NODE_VERSION_COMMAND}
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        OUTPUT_VARIABLE NODE_VERSION
    )
    strip(NODE_VERSION ${NODE_VERSION})
    set(NODE_VERSION ${NODE_VERSION} CACHE STRING "NodeJS version number." FORCE)
    message(STATUS "    NODE_VERSION = ${NODE_VERSION}")


    # Collect Node Addon-API headers into NODE_ADDON_API_DIR
    execute_process(
        COMMAND ${NODE_EXECUTABLE} -p "require('node-addon-api').include"
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        OUTPUT_VARIABLE NODE_ADDON_API_DIR
    )
    string(REGEX REPLACE "[\r\n\"]" "" NODE_ADDON_API_DIR ${NODE_ADDON_API_DIR})
    set(NODE_ADDON_API_DIR ${NODE_ADDON_API_DIR} CACHE STRING "Node Addon-API headers directory" FORCE)
    message(STATUS "    NODE_ADDON_API_DIR = ${NODE_ADDON_API_DIR}")

    set (NPM_COMMAND "${NPM_EXECUTABLE}" CACHE STRING "Call npm commands from here." FORCE)
    set (NPX_COMMAND "${NPX_EXECUTABLE}" CACHE STRING "Call npx commands from here." FORCE)

    # # create config header
    # configure_file(

    #     ${CMAKE_CURRENT_LIST_DIR}/support/node/.env.node.in
    #     ${PROJECT_BINARY_DIR}/.env.node
    #     @ONLY

    # )

    # # create config header
    # configure_file(

    #     ${CMAKE_CURRENT_LIST_DIR}/support/node/include/node/node-js-config.h.in
    #     ${PROJECT_BINARY_DIR}/include/node/node-js-config.h
    #     @ONLY

    # )

    # NodeJS Environment Variables.

    # set (ENV{FORCE_COLOR} "")

    # set (FORCE_COLOR "" CACHE STRING "When set to 'true', 1, 2, 3, or an empty string causes NO_COLOR and NODE_DISABLE_COLORS to be ignored.")#cmakedefine FORCE_COLOR @FORCE_COLOR@
    # set (NO_COLOR "" CACHE STRING "Alias for NODE_DISABLE_COLORS.")
    # set (NODE_DEBUG "" CACHE STRING "','-separated list of core modules that should print debug information.")
    # set (NODE_DEBUG_NATIVE "" CACHE STRING "','-separated list of C++ core debug categories that should print debug output.")
    # set (NODE_DISABLE_COLORS "" CACHE STRING "Set to 1 to disable colors in the REPL.")
    # set (NODE_EXTRA_CA_CERTS "" CACHE PATH "path to additional CA certificates file. Only read once during process startup.")
    # set (NODE_NO_WARNINGS "" CACHE STRING "set to 1 to silence process warnings.")
    # set (NODE_PATH "" CACHE PATH "';'-separated list of directories prefixed to the module search path.")
    # set (NODE_PENDING_DEPRECATION "" CACHE STRING "set to 1 to emit pending deprecation warnings.")
    # set (NODE_PENDING_PIPE_INSTANCES "" CACHE STRING "set the number of pending pipe instance handles on Windows.")

    # /** set to 1 to preserve symbolic links when resolving and caching modules. */
    # #cmakedefine NODE_PRESERVE_SYMLINKS @NODE_PRESERVE_SYMLINKS@

    # /** write warnings to path instead of stderr. */
    # #cmakedefine NODE_REDIRECT_WARNINGS "@NODE_REDIRECT_WARNINGS@"

    # /** path to a Node.js module which will be loaded in place of the built-in REPL. */
    # #cmakedefine NODE_REPL_EXTERNAL_MODULE "@NODE_REPL_EXTERNAL_MODULE@"

    # /** path to the persistent REPL history file. */
    # #cmakedefine NODE_REPL_HISTORY "@NODE_REPL_HISTORY@"

    # /** set to 1 to skip the check for a supported platform during Node.js startup. */
    # #cmakedefine NODE_SKIP_PLATFORM_CHECK @NODE_SKIP_PLATFORM_CHECK@

    # /** set to 0 to disable TLS certificate validation. */
    # #cmakedefine NODE_TLS_REJECT_UNAUTHORIZED @NODE_TLS_REJECT_UNAUTHORIZED@

    # /** directory to output v8 coverage JSON to. */
    # #cmakedefine NODE_V8_COVERAGE "@NODE_V8_COVERAGE@"

    # /** specify the timezone configuration */
    # #cmakedefine TZ "@TZ@"

    # /** sets the number of threads used in libuv's threadpool. */
    # #cmakedefine UV_THREADPOOL_SIZE @UV_THREADPOOL_SIZE@


endif ()


set (NODE_ADDON_LANGUAGES "C;CXX" CACHE STRING "Languages to enables for this addon" FORCE)

## Name the project vendor (for namespace)
set (PROJECT_VENDOR "cmodules")

## Create Project
project ("node-addon" ${NODE_ADDON_LANGUAGES})

set (PROJECT_BINARY_DIR "${PROJECT_SOURCE_DIR}/build/${VCPKG_TARGET_TRIPLET}")

# Parse the vendor name into vars
string (TOUPPER ${PROJECT_VENDOR} PROJECT_VENDOR_UPPER)
string (TOLOWER ${PROJECT_VENDOR} PROJECT_VENDOR_LOWER)

# Parse the project name into vars
string (TOUPPER ${PROJECT_NAME} PROJECT_NAME_UPPER)
string (TOLOWER ${PROJECT_NAME} PROJECT_NAME_LOWER)

set (DEBUG_POSTFIX d CACHE STRING "Debug library postfix." FORCE)

# Set DEBUG_POSTFIX and LIB_NAME for output files.
if (CMAKE_BUILD_TYPE STREQUAL "Debug")

    set (${PROJECT_NAME_UPPER}_LIB_NAME ${PROJECT_NAME_LOWER}.${DEBUG_POSTFIX})

else ()

    set (${PROJECT_NAME_UPPER}_LIB_NAME ${PROJECT_NAME_LOWER})

endif ()

execute_process (
    COMMAND node -p "require('./package.json').version;"
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    OUTPUT_VARIABLE PROJECT_VERSION
)

string (REGEX REPLACE "[\r\n\"]" "" PROJECT_VERSION ${PROJECT_VERSION})
set (PROJECT_VERSION ${PROJECT_VERSION} CACHE STRING "Node Addon version" FORCE)

include (SetInstallDirs)
include (SetEnvDefaults)

# create config header
configure_file (

    ${CMAKE_CURRENT_LIST_DIR}/support/node/.env.node.in
    ${PROJECT_BINARY_DIR}/.env.node
    @ONLY

)

# create config header
configure_file (

    ${CMAKE_CURRENT_LIST_DIR}/support/node/include/node/node-js-config.h.in
    ${PROJECT_BINARY_DIR}/include/node/node-js-config.h
    @ONLY

)

set(MAIN_TEST_H_FILE "${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/main.h")
set(MAIN_TEST_C_FILE "${PROJECT_BINARY_DIR}/src/main.cpp")

configure_file (

    "${CMAKE_CURRENT_LIST_DIR}/test/project/cmodule-v1.0.1-source/include/cmodule/main.h"
    ${MAIN_TEST_H_FILE}
    @ONLY

)

configure_file (

    "${CMAKE_CURRENT_LIST_DIR}/test/project/cmodule-v1.0.1-source/src/main.cpp"
    ${MAIN_TEST_C_FILE}
    @ONLY

)


add_library (${PROJECT_NAME} SHARED)
add_library (${PROJECT_VENDOR}::${PROJECT_NAME} ALIAS ${PROJECT_NAME})

target_sources (${PROJECT_NAME}

    PUBLIC

        ${MAIN_TEST_H_FILE}
        ${MAIN_TEST_C_FILE}
        "${PROJECT_BINARY_DIR}/include/node/node-js-config.h"

)

target_include_directories (${PROJECT_NAME}

    PUBLIC

        ${PROJECT_BINARY_DIR}/include

)

# Set target output file properties.
set_target_properties (${PROJECT_NAME}

    PROPERTIES

        CXX_STANDARD 11
        CXX_STANDARD_REQUIRED TRUE
        RUNTIME_OUTPUT_DIRECTORY bin
        LIBRARY_OUTPUT_DIRECTORY lib
        ARCHIVE_OUTPUT_DIRECTORY lib
        PDB_OUTPUT_DIRECTORY bin
        PREFIX ""
        SUFFIX ".node"
        # DEBUG_POSTFIX ${${PROJECT_NAME_UPPER}_DEBUG_POSTFIX}
        # Add an interface compatibility check, to check linkage against (increasing VERSION_MAJOR is by definition a 'breaking change')
        # COMPATIBLE_INTERFACE_STRING ${PROJECT_NAME_UPPER}_VERSION_MAJOR
        # INTERFACE_${PROJECT_NAME_UPPER}_VERSION_MAJOR ${${PROJECT_NAME}_VERSION_MAJOR}
        # SOURCES
        # PUBLIC_HEADER
        # PRIVATE_HEADER

)

find_package(unofficial-node-api-headers CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE unofficial::node-api-headers::node-api-headers)


find_package(unofficial-node-addon-api CONFIG REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE unofficial::node-addon-api::node-addon-api)

include(GetEnvVars)
