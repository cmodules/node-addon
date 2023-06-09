# Generated by CMake

if("${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION}" LESS 2.8)
   message(FATAL_ERROR "CMake >= 2.8.0 required")
endif()
if(CMAKE_VERSION VERSION_LESS "2.8.3")
   message(FATAL_ERROR "CMake >= 2.8.3 required")
endif()
cmake_policy(PUSH)
cmake_policy(VERSION 2.8.3...3.24)
#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Protect against multiple inclusion, which would fail when already imported targets are added once more.
set(_cmake_targets_defined "")
set(_cmake_targets_not_defined "")
set(_cmake_expected_targets "")
foreach(_cmake_expected_target IN ITEMS StoneyDSP::cmodule)
  list(APPEND _cmake_expected_targets "${_cmake_expected_target}")
  if(TARGET "${_cmake_expected_target}")
    list(APPEND _cmake_targets_defined "${_cmake_expected_target}")
  else()
    list(APPEND _cmake_targets_not_defined "${_cmake_expected_target}")
  endif()
endforeach()
unset(_cmake_expected_target)
if(_cmake_targets_defined STREQUAL _cmake_expected_targets)
  unset(_cmake_targets_defined)
  unset(_cmake_targets_not_defined)
  unset(_cmake_expected_targets)
  unset(CMAKE_IMPORT_FILE_VERSION)
  cmake_policy(POP)
  return()
endif()
if(NOT _cmake_targets_defined STREQUAL "")
  string(REPLACE ";" ", " _cmake_targets_defined_text "${_cmake_targets_defined}")
  string(REPLACE ";" ", " _cmake_targets_not_defined_text "${_cmake_targets_not_defined}")
  message(FATAL_ERROR "Some (but not all) targets in this export set were already defined.\nTargets Defined: ${_cmake_targets_defined_text}\nTargets not yet defined: ${_cmake_targets_not_defined_text}\n")
endif()
unset(_cmake_targets_defined)
unset(_cmake_targets_not_defined)
unset(_cmake_expected_targets)


# Create imported target StoneyDSP::cmodule
add_library(StoneyDSP::cmodule SHARED IMPORTED)

set_target_properties(StoneyDSP::cmodule PROPERTIES
  COMPATIBLE_INTERFACE_STRING "CMODULE_VERSION_MAJOR"
  INTERFACE_CMODULE_VERSION_MAJOR "1"
  INTERFACE_COMPILE_DEFINITIONS "UNICODE;_UNICODE;NAPI_VERSION=8;BUILDING_NODE_EXTENSION;WINDOWS"
  INTERFACE_COMPILE_FEATURES "cxx_std_11"
  INTERFACE_COMPILE_OPTIONS "/W3"
  INTERFACE_INCLUDE_DIRECTORIES "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule;C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule"
  INTERFACE_LINK_LIBRARIES "CMakeJS::CMakeJS"
  INTERFACE_LINK_OPTIONS "/DELAYLOAD:NODE.EXE"
)

if(NOT CMAKE_VERSION VERSION_LESS "3.23.0")
  target_sources(StoneyDSP::cmodule
    INTERFACE
      FILE_SET "cmodule_HEADERS"
      TYPE "HEADERS"
      BASE_DIRS "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule" "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule" "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule" "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule"
      FILES "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule/add.h" "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule/binding.h" "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule/calc.h" "C:/Users/natha/Development/StoneyDSP/cmodule/include/cmodule/main.h"
  )
endif()

# Import target "StoneyDSP::cmodule" for configuration "Debug"
set_property(TARGET StoneyDSP::cmodule APPEND PROPERTY IMPORTED_CONFIGURATIONS DEBUG)
set_target_properties(StoneyDSP::cmodule PROPERTIES
  IMPORTED_IMPLIB_DEBUG "C:/Users/natha/Development/StoneyDSP/cmodule/build/lib/Debug/cmodule.lib"
  IMPORTED_LOCATION_DEBUG "C:/Users/natha/Development/StoneyDSP/cmodule/build/bin/Debug/cmodule.node"
  )

# Import target "StoneyDSP::cmodule" for configuration "Release"
set_property(TARGET StoneyDSP::cmodule APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(StoneyDSP::cmodule PROPERTIES
  IMPORTED_IMPLIB_RELEASE "C:/Users/natha/Development/StoneyDSP/cmodule/build/lib/Release/cmodule.lib"
  IMPORTED_LOCATION_RELEASE "C:/Users/natha/Development/StoneyDSP/cmodule/build/bin/Release/cmodule.node"
  )

# Import target "StoneyDSP::cmodule" for configuration "MinSizeRel"
set_property(TARGET StoneyDSP::cmodule APPEND PROPERTY IMPORTED_CONFIGURATIONS MINSIZEREL)
set_target_properties(StoneyDSP::cmodule PROPERTIES
  IMPORTED_IMPLIB_MINSIZEREL "C:/Users/natha/Development/StoneyDSP/cmodule/build/lib/MinSizeRel/cmodule.lib"
  IMPORTED_LOCATION_MINSIZEREL "C:/Users/natha/Development/StoneyDSP/cmodule/build/bin/MinSizeRel/cmodule.node"
  )

# Import target "StoneyDSP::cmodule" for configuration "RelWithDebInfo"
set_property(TARGET StoneyDSP::cmodule APPEND PROPERTY IMPORTED_CONFIGURATIONS RELWITHDEBINFO)
set_target_properties(StoneyDSP::cmodule PROPERTIES
  IMPORTED_IMPLIB_RELWITHDEBINFO "C:/Users/natha/Development/StoneyDSP/cmodule/build/lib/RelWithDebInfo/cmodule.lib"
  IMPORTED_LOCATION_RELWITHDEBINFO "C:/Users/natha/Development/StoneyDSP/cmodule/build/bin/RelWithDebInfo/cmodule.node"
  )

# Make sure the targets which have been exported in some other
# export set exist.
unset(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE_targets)
foreach(_target "CMakeJS::CMakeJS" )
  if(NOT TARGET "${_target}" )
    set(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE_targets "${${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE_targets} ${_target}")
  endif()
endforeach()

if(DEFINED ${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE_targets)
  if(CMAKE_FIND_PACKAGE_NAME)
    set( ${CMAKE_FIND_PACKAGE_NAME}_FOUND FALSE)
    set( ${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE "The following imported targets are referenced, but are missing: ${${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE_targets}")
  else()
    message(FATAL_ERROR "The following imported targets are referenced, but are missing: ${${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE_targets}")
  endif()
endif()
unset(${CMAKE_FIND_PACKAGE_NAME}_NOT_FOUND_MESSAGE_targets)

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
cmake_policy(POP)
