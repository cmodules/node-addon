#!/usr/bin/env cmake

# @StoneyDSP/GetEnvVars.cmake - a CMake module for collecting all config-time env vars into a .env file (MIT 2023)

# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
GetEnvVars
----------

A CMake module for collecting all config-time env vars into a .env file.

This module defines

::

  ENV_VARS_ALL, All known/found/active env vars from CMake config step
  ENV_VARS_FOUND, If false, do not try to use CMakeJs.

also defined, but not for general use are

::

  _os_name, a lower-casing of the host system name (for appending to the output '.env' file name).

#]=======================================================================]


# string(REPLACE ";" "\n" file_text ${file_text})

function(get_env_vars)

    execute_process(
        COMMAND "${CMAKE_COMMAND}" "-E" "environment"
        WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
        OUTPUT_VARIABLE ENV_VARS_ALL
    )

    # Normalize slash characters to be uni-directional
    # Set all EOL's to LF-style
    # Insert an 'open-quote' char after all 'equals' chars
    # Insert a 'close-quote' char after all LF-style EOL's :)

    string(REGEX REPLACE "[\\]" "/" ENV_VARS_ALL ${ENV_VARS_ALL})
    string(REGEX REPLACE "[\r\n]" "\n" ENV_VARS_ALL ${ENV_VARS_ALL})
    string(REGEX REPLACE "[=]" "=\"" ENV_VARS_ALL ${ENV_VARS_ALL})
    string(REGEX REPLACE "[\n]" "\"\n" ENV_VARS_ALL ${ENV_VARS_ALL})

    if (DEFINED WIN32)
        # Revert all slash chars to windows-style
        # Revert all LF EOL's to CRLF :)
        # string(REGEX REPLACE "[/]" "\\" ENV_VARS_ALL ${ENV_VARS_ALL})
        # string(REGEX REPLACE "[\n]" "\r\n" ENV_VARS_ALL ${ENV_VARS_ALL})
    endif ()

    string(TOLOWER ${CMAKE_HOST_SYSTEM_NAME} _os_name)

    # Define @ENV_VARS_ALL@ in the below input file. The expanded results will
    # appear in the below output file.
    configure_file(
        ${PROJECT_SOURCE_DIR}/support/environment/.env.local
        ${PROJECT_BINARY_DIR}/.env.local.${_os_name}
        @ONLY
    )

    unset (_os_name)

endfunction()

get_env_vars()
