#!/usr/bin/env cmake

# @StoneyDSP/Stringify.cmake - a CMake module for fixing string variables (MIT 2023)

# Distributed under the MIT License.  See accompanying
# file LICENSE.txt for details.

#[=======================================================================[.rst:
Stringify
--------

A CMake module for fixing string variables.

This module defines

::

  strip()
  escape()
  strip_and_escape()

also defined, but not for general use are

::

#]=======================================================================]

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

#
#Definition:
#
#function (strip result value)
#
#    string (REGEX REPLACE "[\r\n\"]" "" value "${value}")
#
#    set (${result} "${value}" PARENT_SCOPE)
#
#    unset(value)
#
#endfunction ()
#
function (strip result value)

    string (REGEX REPLACE "[\r\n\"]" "" value "${value}")

    set (${result} "${value}" PARENT_SCOPE)

    unset(value)

endfunction ()

#
#Definition:
#
#function (escape result value)
#
#    string(REPLACE "\\" "\\\\" value "${value}")
#    string(REPLACE "\"" "\\\"" value "${value}")
#    string(REPLACE "\$" "\\\$" value "${value}")
#
#    set(${result} "${value}" PARENT_SCOPE)
#
#    unset(result)
#
#endfunction ()
#
function (escape result value)

    string(REPLACE "\\" "\\\\" value "${value}")
    string(REPLACE "\"" "\\\"" value "${value}")
    string(REPLACE "\$" "\\\$" value "${value}")

    set(${result} "${value}" PARENT_SCOPE)

    unset(value)

endfunction ()

#
#function (escape_and_strip result value)
#
#    strip (${thru_1} "${value}")
#
#    escape (${thru_2} ${thru_1})
#
#    set (${result} ${thru_2} PARENT_SCOPE)
#
#    unset (value)
#    unset (thru_1)
#    unset (thru_2)
#
#endfunction ()
#
function (escape_and_strip result value)

    strip (${thru_1} "${value}")

    escape (${thru_2} ${thru_1})

    set (${result} ${thru_2} PARENT_SCOPE)

    unset (value)
    unset (thru_1)
    unset (thru_2)

endfunction ()
