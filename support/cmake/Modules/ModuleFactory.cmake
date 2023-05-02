# Module factory characteristics;

# - Always builds out-of-source
# - Copies all required files into build tree
# - Generate step only runs once!

# Specifically;

# - Sources and headers in the source tree exist only as project templates;
# these are configure-copied over into the binary tree during configuration,
# where from they can be modified and over-written.

# - The newly-built binary tree is infact a whole new project, to be opened
# in the supported IDE as chosen by the generator. The entire project
# configuration is infact the configuration-step's generated CMakeCache.txt
# file. The IDE project (or solution) files are hooked into this.

# - All file linkage therefore only exists between the files in the build tree,
# with the exception of the required Node/CMakeJS headers (which we may
# optionally copy over into the binary tree during the configuration step).

# - A warning must be issued when attempting to overwrite an existing binary
# tree, i.e, an existing project, or it's associated CMakeCache.txt file.

# - Since any specified package dependencies must be available to the new
# project tree, dependency resolution should happen *BEFORE* the target's
# own project is detected, from the root factory-level project.

# - 'Saving a new project', i.e., creating a new binary tree, should not be
# allowable to happen within the factory's own data tree, as this will likely
# cause a mayhem not worth considering.

# - The factory is essentially responsible for using a generator to configure
# a new project which can be opened in an IDE, or built directly using CLI tools.

# - The generated 'new project' header and source files should not be over-written
# by re-running the generator/configure-project step, as this will cause
# damage/data loss when re-configuring existing projects.

# - The factory is essentially not responsible for doing the actual compiling.
# It will provide all the initial configuration information for the solution,
# but is essentially no longer needed once the CMake configuration step is complete.

# CMake requirements.
cmake_minimum_required(VERSION 3.9...3.26.3)
# Cmake-js requirements
cmake_policy(SET CMP0091 NEW)
cmake_policy(SET CMP0042 NEW)
# Fallback for using newer policies on CMake < 3.12.
if(${CMAKE_VERSION} VERSION_LESS 3.12)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

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

# Import some custom helpers to set up CMake for NodeJS development
set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${CMAKE_CURRENT_SOURCE_DIR}/support/cmake/Modules
)

## Name the project vendor (for namespace)
set(PROJECT_VENDOR "StoneyDSP")
## Create Project
project("factory"
    VERSION "0.0.0.20230430"
    DESCRIPTION "NodeJS factory written in C++"
    HOMEPAGE_URL "https://github.com/StoneyDSP/cmodule"
    LANGUAGES CXX
)
