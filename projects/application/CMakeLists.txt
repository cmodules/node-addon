cmake_minimum_required (VERSION 3.15...3.26.3 FATAL_ERROR)

project (application NONE)

set (${PROJECT_NAME}_VENDOR "StoneyDSP" CACHE STRING "Name of the vendor of ${PROJECT_NAME}." FORCE)

set (${PROJECT_NAME}_VERSION "1.0.0.0" CACHE STRING "Value given to the ``VERSION`` option of the most recent call to the ``project()`` command, if any." FORCE)
set (${PROJECT_NAME}_DESCRIPTION "NodeJS module written in C++" CACHE STRING "Short project description given to the project command." FORCE)
set (${PROJECT_NAME}_HOMEPAGE_URL "https://github.com/StoneyDSP/cmodule" CACHE STRING "The homepage URL of the project." FORCE)

# # specify the C standard
# set(CMAKE_C_STANDARD 17)
# set(CMAKE_C_STANDARD_REQUIRED True)

# # specify the C++ standard
# if (CMAKE_VERSION VERSION_GREATER 3.12)
#   set(CMAKE_CXX_STANDARD 20)
# else()
#   set(CMAKE_CXX_STANDARD 17)
# endif()
# set(CMAKE_CXX_STANDARD_REQUIRED True)

set (GCC_CXX "$<CXX_COMPILER_ID:GNU,Clang,AppleClang,ARMClang,LCC>")
set (MSVC_CXX "$<CXX_COMPILER_ID:MSVC>")

set (USING_MSVC "$<BOOL:${MSVC}>")


enable_language(C)
enable_language(CXX)

if (NOT ${PROJECT_SOURCE_DIR} EQUAL ${PROJECT_BINARY_DIR})

  # Note that the output file automatically falls into the binary dir
  configure_file ("include/application/configuration.h"       "include/${PROJECT_NAME}/configuration.h")
  configure_file ("include/application/impl/library.h"        "include/${PROJECT_NAME}/impl/library.h")
  configure_file ("include/application/staticlib.h"           "include/${PROJECT_NAME}/staticlib.h")
  configure_file ("include/application/sharedlib.h"           "include/${PROJECT_NAME}/sharedlib.h")
  configure_file ("include/application/runtime/main.h"        "include/${PROJECT_NAME}/runtime/main.h")

  # Copy sources too...
  configure_file ("src/impl/library.cpp"                      "src/impl/library.cpp")
  configure_file ("src/staticlib.cpp"                         "src/staticlib.cpp")
  configure_file ("src/sharedlib.cpp"                         "src/sharedlib.cpp")
  configure_file ("src/runtime/main.cpp"                      "src/runtime/main.cpp")

endif ()




# An interface library is a target that can be linked with, except that it
# doesn't generate any compiled output of it's own - it's just for other
# parts of our project to consume.
add_library (configuration                                      INTERFACE)
add_library (${PROJECT_NAME}::configuration                     ALIAS configuration)
add_library (${PROJECT_NAME}::${PROJECT_NAME}::configuration    ALIAS configuration)

target_include_directories (configuration

    INTERFACE

        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

# This configured header is 'Public', meaning it can be included by anything
# that links to this target. However, it stays in a project-named folder so
# that other projects cannot (or shouldn't be able to) include it using
# system header "<>" syntax
target_sources (configuration

    PUBLIC

        FILE_SET configuration_PUBLIC_HEADERS
        TYPE HEADERS
        BASE_DIRS
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
            $<INSTALL_INTERFACE:include>
        FILES
            # include/application/configuration.h
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/configuration.h>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}/configuration.h>
)

target_compile_options (configuration
    INTERFACE
    "$<${GCC_CXX}:>"
    "$<${MSVC_CXX}:>"
)

set_target_properties (configuration

    PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY bin
        LIBRARY_OUTPUT_DIRECTORY lib
        ARCHIVE_OUTPUT_DIRECTORY lib
        PDB_OUTPUT_DIRECTORY     bin
)


add_library (implementation                                         INTERFACE)
add_library (${PROJECT_NAME}::implementation                        ALIAS implementation)
add_library (${PROJECT_VENDOR}::${PROJECT_NAME}::implementation     ALIAS implementation)

target_include_directories (implementation

    INTERFACE

        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/impl>
        $<INSTALL_INTERFACE:include/impl>
)

target_sources (implementation

    PUBLIC

        FILE_SET implementation_PUBLIC_HEADERS
        TYPE HEADERS
        BASE_DIRS
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
            $<INSTALL_INTERFACE:include>
        FILES
            # include/application/impl/library.h
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/impl/library.h>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}/impl/library.h>
)

# Implementation sources MUST be PUBLIC, otherwise nothing can link
# to the code definitions contained therein
target_sources (implementation

    PUBLIC

        # src/impl/library.cpp
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/src/impl/library.cpp>
        $<INSTALL_INTERFACE:src/impl/library.cpp>
)


set_target_properties (implementation

    PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY bin
        LIBRARY_OUTPUT_DIRECTORY lib
        ARCHIVE_OUTPUT_DIRECTORY lib
        PDB_OUTPUT_DIRECTORY     bin
)


add_library (static                                         STATIC)
add_library (${PROJECT_NAME}::static                        ALIAS static)
add_library (${PROJECT_NAME}::${PROJECT_NAME}::static       ALIAS static)

target_include_directories (static

    PUBLIC

        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

target_sources (static

    PUBLIC

        FILE_SET static_PUBLIC_HEADERS
        TYPE HEADERS
        BASE_DIRS
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}>
        FILES
            # include/${PROJECT_NAME}/staticlib.h
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/staticlib.h>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}/staticlib.h>
)

target_sources (static

    PRIVATE

        # src/staticlib.cpp
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/src/staticlib.cpp>
        $<INSTALL_INTERFACE:src/staticlib.cpp>
)

set_target_properties (static

    PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY bin
        LIBRARY_OUTPUT_DIRECTORY lib
        ARCHIVE_OUTPUT_DIRECTORY lib
        PDB_OUTPUT_DIRECTORY     bin
)

target_link_libraries (static

    ${PROJECT_NAME}::configuration
    ${PROJECT_NAME}::implementation
)


add_library (shared                                         SHARED)
add_library (${PROJECT_NAME}::shared                        ALIAS shared)
add_library (${PROJECT_NAME}::${PROJECT_NAME}::shared       ALIAS shared)

target_include_directories (shared

    PUBLIC

        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:include>
)

target_sources (shared

    PUBLIC

        FILE_SET shared_PUBLIC_HEADERS
        TYPE HEADERS
        BASE_DIRS
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}>
        FILES
            # include/${PROJECT_NAME}/sharedlib.h
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/sharedlib.h>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}/sharedlib.h>
)

target_sources (shared

    PRIVATE

        # src/sharedlib.cpp
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/src/sharedlib.cpp>
        $<INSTALL_INTERFACE:src/sharedlib.cpp>
)

set_target_properties (shared

    PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY bin
        LIBRARY_OUTPUT_DIRECTORY lib
        ARCHIVE_OUTPUT_DIRECTORY lib
        PDB_OUTPUT_DIRECTORY     bin
)

target_link_libraries (shared

    ${PROJECT_NAME}::configuration
    ${PROJECT_NAME}::implementation
)



add_executable (executable)
add_executable (${PROJECT_NAME}::executable ALIAS executable)
add_executable (${PROJECT_VENDOR}::${PROJECT_NAME}::executable ALIAS executable)

# Note that we *shouldn't* use ${PROJECT_BINARY_DIR} as the include directory
# for user installations of your packages. Once configuration is complete, that
# variable will now be pointing at a fixed location, only consumed when 'building',
# i.e., developing and working on your files within the binarytree.

# CMake will not 'fix' the location variable stored in <INSTALL_INTERFACE>, unless
# or until the 'install' command is used.
target_include_directories(executable

    PRIVATE

        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:include>
)


target_sources (executable

    PRIVATE

        FILE_SET executable_PRIVATE_HEADERS
        TYPE HEADERS
        # 'Private' headers go into a target-named folder,
        # since they aren't intended to be 'shared' among other
        # binaries and libraries.
        BASE_DIRS
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/runtime>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}/runtime>
        FILES
            # include/${PROJECT_NAME}/runtime/main.h
            $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/runtime/main.h>
            $<INSTALL_INTERFACE:include/${PROJECT_NAME}/runtime/main.h>
)

target_sources (executable

    PRIVATE

        # src/runtime/main.cpp
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/src/runtime/main.cpp>
        $<INSTALL_INTERFACE:src/runtime/main.cpp>
)

set_target_properties (executable

    PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY bin
        LIBRARY_OUTPUT_DIRECTORY lib
        ARCHIVE_OUTPUT_DIRECTORY lib
        PDB_OUTPUT_DIRECTORY     bin
)

target_link_libraries (executable

    ${PROJECT_NAME}::configuration
    ${PROJECT_NAME}::implementation
)




#---------------
# CPACK
#---------------
# include(JoinPaths)
# join_paths(libdir_for_pc_file "\${exec_prefix}" "${CMAKE_INSTALL_LIBDIR}")
# join_paths(includedir_for_pc_file "\${prefix}" "${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}")

# # message(STATUS "Creating pkgconfig file...")
# configure_file(
#     ${PROJECT_SOURCE_DIR}/support/cmake/cmodule.pc.in
#     ${PROJECT_BINARY_DIR}/lib/pkgconfig/${PROJECT_NAME_LOWER}.pc
#     @ONLY
# )
# # message(STATUS "Created pkgconfig file at ${${PROJECT_NAME_UPPER}_PACKAGE_CONFIG}\n")

# Configure CPack
set(CPACK_PACKAGE_VENDOR ${PROJECT_VENDOR})
set(CPACK_PACKAGE_NAME "${PROJECT_NAME}-${PROJECT_VERSION}")
set(CPACK_PACKAGE_FILE_NAME "${PROJECT_NAME}-${PROJECT_VERSION}-${CMAKE_SYSTEM_NAME}-${CMAKE_SYSTEM_PROCESSOR}") # Compiled binary distribution
set(CPACK_SOURCE_PACKAGE_FILE_NAME "${PROJECT_NAME}-${PROJECT_VERSION}-Source") # No system spec as this is un-compiled source file distribution
# set(CPACK_PACKAGE_CHECKSUM "${PROJECT_VENDOR}-${PROJECT_NAME}-${PROJECT_VERSION}")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY ${PROJECT_DESCRIPTION})
set(CPACK_PACKAGE_VERSION_MAJOR ${${PROJECT_NAME}_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${${PROJECT_NAME}_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${${PROJECT_NAME}_VERSION_PATCH})
set(CPACK_PACKAGE_VERSION_TWEAK ${${PROJECT_NAME}_VERSION_TWEAK})
# set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_LIST_DIR}/LICENSE)
# set(CPACK_RESOURCE_FILE_README ${CMAKE_CURRENT_LIST_DIR}/README.rst)
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY OFF)
set(CPACK_COMPONENT_INCLUDE_TOPLEVEL_DIRECTORY OFF)
# set(CPACK_PACKAGE_DIRECTORY )
set(CPACK_SOURCE_GENERATOR "TGZ;ZIP")
set(CPACK_SOURCE_IGNORE_FILES
    /.git/*
    /.cmake
    /.github
    /.vs
    /.vscode
    /.cache
    /.config
    /.local
    /.editorconfig
    /bin
    /lib
    /share
    /etc
    /build
    /Release
    /Debug
    /MinSizeRel
    /RelWithDebInfo
    /downloads
    /installed
    /node_modules
    /vcpkg
    /.*build.*
    /package-lock.json
    /yarn.lock
    /\\\\.DS_Store
)
include(CPack)


#---------------
# EXPORT TARGETS
#---------------

set (${PROJECT_NAME}_TARGETS shared static executable implementation configuration CACHE STRING "Targets to be built." FORCE)

# export(
#     TARGETS ${${PROJECT_NAME}_TARGETS}
#     FILE ${PROJECT_BINARY_DIR}/share/${PROJECT_VENDOR}${PROJECT_NAME}Targets.cmake
#     NAMESPACE ${PROJECT_VENDOR}::${PROJECT_NAME}::
# )

export(
    TARGETS ${${PROJECT_NAME}_TARGETS}
    FILE ${PROJECT_BINARY_DIR}/share/${PROJECT_NAME}Targets.cmake
    NAMESPACE ${PROJECT_NAME}::
)

#---------------
# INSTALL TARGETS
#---------------

# # Install the library and headers.
# install(
#     TARGETS configuration implementation static shared executable
#     EXPORT ${PROJECT_NAME}Targets
#     LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
#     ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
#     INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
#     PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
#     PRIVATE_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
#     # FRAMEWORK DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
#     # FILE_SET ${PROJECT_NAME_LOWER}_HEADERS DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
#     # FILE_SET ${PROJECT_NAME_LOWER}_PRIVATE_HEADERS DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
# )

# install(
#     EXPORT ${PROJECT_NAME}Targets
#     DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}
#     NAMESPACE ${PROJECT_VENDOR}::
# )

# install(
#     FILES
#         ${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/include/application.h
#         ${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/include/sharedlib.h
#         ${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}/include/staticlib.h
#     DESTINATION
#         ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME}
# )

# install(
#     FILES
#         ${PROJECT_BINARY_DIR}/share/${PROJECT_NAME}Config.cmake
#         ${PROJECT_BINARY_DIR}/share/${PROJECT_NAME}ConfigVersion.cmake
#     DESTINATION
#         ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}
# )

# install(
#     FILES
#         ${PROJECT_BINARY_DIR}/lib/pkgconfig/${PROJECT_NAME_LOWER}.pc
#     DESTINATION
#         ${CMAKE_INSTALL_LIBDIR}/pkgconfig
# )
