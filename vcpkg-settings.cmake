#!/usr/bin/cmake -e
cmake_minimum_required (VERSION 3.14...3.26 FATAL_ERROR)

if (${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
    message (FATAL_ERROR "Cannot configure into source tree - please choose a different binary directory!")
    return ()
endif ()

# set (VCPKG_INSTALLED_DIR "${CMAKE_CURRENT_LIST_DIR}/installed")
# set (VCPKG_ARTIFACTS_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/vcpkg-artifacts")
# set (VCPKG_ARTIFACTS_DEVELOPMENT ON)

macro (setup_vcpkg)

    message (STATUS "Loading 'vcpkg-settings.cmake'...")



    if (NOT DEFINED CMAKE_C_STANDARD_DEFAULT)
        set (CMAKE_C_STANDARD_DEFAULT "17")
    endif ()
    if (NOT DEFINED CMAKE_CXX_STANDARD_DEFAULT)
        set (CMAKE_CXX_STANDARD_DEFAULT "17")
    endif ()

    if (NOT DEFINED CMAKE_C_STANDARD)
        set (CMAKE_C_STANDARD "${CMAKE_C_STANDARD_DEFAULT}")
    endif ()
    if (NOT DEFINED CMAKE_CXX_STANDARD)
        set (CMAKE_CXX_STANDARD "${CMAKE_CXX_STANDARD_DEFAULT}")
    endif ()

    set (BUILD_TESTS ON CACHE BOOL "Build tests")

    if (NOT DEFINED CMAKE_C_STANDARD_REQUIRED)
        set (CMAKE_C_STANDARD_REQUIRED ON)
    endif ()
    if (NOT DEFINED CMAKE_CXX_STANDARD_REQUIRED)
        set (CMAKE_CXX_STANDARD_REQUIRED ON)
    endif ()

    option (BUILD_TESTS "Build tests" ON)
    option (USE_X64 "True if using x64 host triplet." ON)
    option (USE_PROJECT_VCPKG "" ON)
    option (BUILD_SHARED_LIBS "Global flag to cause ``add_library()`` to create shared libraries by default, if on." ON)
    option (BUILD_VCPKG "True if building vcpkg locally" OFF)
    option (VCPKG_USE_HOST_TOOLS "Setup CMAKE_PROGRAM_PATH to use host tools" OFF)

    if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/projects/cmrc/CMakeLists.txt")
        set (FETCHCONTENT_SOURCE_DIR_CMAKERC "${CMAKE_CURRENT_LIST_DIR}/projects/cmrc" CACHE PATH "When not empty, overrides where to find pre-populated content for CMakeRC." FORCE)
    endif ()

    if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/projects/fmt/CMakeLists.txt")
        set (FETCHCONTENT_SOURCE_DIR_FMT "${CMAKE_CURRENT_LIST_DIR}/projects/fmt" CACHE PATH "When not empty, overrides where to find pre-populated content for fmt." FORCE)
    endif ()

    # Set all vcpkg env vars here, and inherit them later...
    if (USE_PROJECT_VCPKG)

        if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/archives")
            execute_process (
                COMMAND "${CMAKE_COMMAND}" -E make_directory "archives"
                WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
            )
        endif ()

        if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/buildtrees")
            execute_process (
                COMMAND "${CMAKE_COMMAND}" -E make_directory "buildtrees"
                WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
            )
        endif ()

        if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/downloads")
            execute_process (
                COMMAND "${CMAKE_COMMAND}" -E make_directory "downloads"
                WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
            )
        endif ()

        if (NOT DEFINED VCPKG_INSTALLED_DIR AND NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/installed")
            execute_process (
                COMMAND "${CMAKE_COMMAND}" -E make_directory "installed"
                WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
                OUTPUT_VARIABLE VCPKG_INSTALLED_DIR
            )
        endif ()

        if (NOT EXISTS "${CMAKE_CURRENT_LIST_DIR}/packages")
            execute_process (
                COMMAND "${CMAKE_COMMAND}" -E make_directory "packages"
                WORKING_DIRECTORY "${CMAKE_CURRENT_LIST_DIR}"
            )
        endif ()

        unset (ENV{VCPKG_FORCE_DOWNLOAD_BINARIES})
        unset (ENV{VCPKG_MAX_CONCURRENCY})
        unset (ENV{VCPKG_KEEP_ENV_VARS})

        set (ENV{VCPKG_ROOT}                    "${CMAKE_CURRENT_LIST_DIR}")
        set (ENV{VCPKG_DOWNLOADS}               "${CMAKE_CURRENT_LIST_DIR}/downloads")
        set (ENV{VCPKG_DEFAULT_BINARY_CACHE}    "${CMAKE_CURRENT_LIST_DIR}/archives")
        set (ENV{VCPKG_OVERLAY_PORTS}           "${CMAKE_CURRENT_LIST_DIR}/ports")
        set (ENV{VCPKG_OVERLAY_TRIPLETS}        "${CMAKE_CURRENT_LIST_DIR}/triplets")
        set (ENV{VCPKG_BINARY_SOURCES}          "clear;default,readwrite")
        set (ENV{VCPKG_FORCE_SYSTEM_BINARIES}   ON)

        ## deprecated!! Use empty overlay ports instead...
        # set (ENV{VCPKG_PREFER_SYSTEM_LIBS}    ON)

    endif ()

    if (NOT DEFINED ENV{VCPKG_DEFAULT_HOST_TRIPLET})
        if (USE_X64)
            if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows" OR "")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x64-windows")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x64-linux")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x64-osx")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Android")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x64-android")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "iOS")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x64-ios")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "WindowsStore")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x64-uwp")
            endif ()
        else ()
            if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows" OR "")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x86-windows")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x86-linux")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x86-osx")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Android")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x86-android")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "iOS")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x86-ios")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "WindowsStore")
                set (ENV{VCPKG_DEFAULT_HOST_TRIPLET} "x86-uwp")
            endif ()
        endif ()
    endif ()

    if (NOT DEFINED CMAKE_SYSTEM_NAME)
        set (CMAKE_SYSTEM_NAME "${CMAKE_HOST_SYSTEM_NAME}" CACHE STRING "Specifies the target machine arhitecture. Valid options are 'x86', 'x64', 'arm', 'arm64', and 'wasm32'.")
    endif ()
    if (NOT DEFINED CMAKE_SYSTEM_VERSION)
        set (CMAKE_SYSTEM_VERSION "${CMAKE_HOST_SYSTEM_VERSION}" CACHE STRING "Specifies the target machine arhitecture. Valid options are 'x86', 'x64', 'arm', 'arm64', and 'wasm32'.")
    endif ()

    # Inherit and propagate default triplets...
    if (NOT DEFINED VCPKG_DEFAULT_HOST_TRIPLET)
        set (VCPKG_DEFAULT_HOST_TRIPLET "$ENV{VCPKG_DEFAULT_HOST_TRIPLET}" CACHE STRING "This environment variable can be set to a triplet name which will be used for unqualified triplet references in command lines.")
    endif ()
    if (NOT DEFINED VCPKG_HOST_TRIPLET)
        set (VCPKG_HOST_TRIPLET "${VCPKG_DEFAULT_HOST_TRIPLET}" CACHE STRING "This variable controls which triplet the host dependencies will be installed for. If unset, vcpkg will automatically detect a native triplet ('x64-windows', 'x64-osx', 'x64-linux').")
    endif ()

    if (NOT DEFINED VCPKG_DEFAULT_TRIPLET)
        set (VCPKG_DEFAULT_TRIPLET "$ENV{VCPKG_DEFAULT_HOST_TRIPLET}" CACHE STRING "This environment variable can be set to a triplet name which will be used for unqualified host port references in command lines and all host port references in dependency lists.")
    endif ()
    if (NOT DEFINED VCPKG_TARGET_TRIPLET)
        set (VCPKG_TARGET_TRIPLET "${VCPKG_DEFAULT_TRIPLET}" CACHE STRING "This setting controls the triplet vcpkg will install and consume libraries from. If unset, vcpkg will automatically detect an appropriate default triplet given the current compiler settings. If you change this variable, you must delete you cache and reconfigure.")
    endif ()


    # vcpkg fundamentals...
    if (NOT DEFINED VCPKG_ROOT)
        set (VCPKG_ROOT "$ENV{VCPKG_ROOT}" CACHE PATH "This environment variable can be set to a directory to use as the root of the vcpkg instance. This will only be used if the vcpkg executable is not located within a valid root and the command line switch '--vcpkg-root' is unused." FORCE)
    endif ()
    if (NOT DEFINED VCPKG_DOWNLOADS)
        set (VCPKG_DOWNLOADS "$ENV{VCPKG_DOWNLOADS}" CACHE PATH "This environment variable can be set to an existing directory to use for storing downloads instead of the internal 'downloads/' directory. It should always be an absolute path." FORCE)
    endif ()
    if (NOT DEFINED VCPKG_DEFAULT_BINARY_CACHE)
        set (VCPKG_DEFAULT_BINARY_CACHE "$ENV{VCPKG_DEFAULT_BINARY_CACHE}" CACHE PATH "This environment variable redirects the default location to store binary packages." FORCE)
    endif ()
    if (NOT DEFINED VCPKG_DEFAULT_BINARY_CACHE)
        set (VCPKG_BINARY_SOURCES "$ENV{VCPKG_BINARY_SOURCES}" CACHE PATH "This environment variable adds or removes binary sources." FORCE)
    endif ()
    if (NOT DEFINED VCPKG_INSTALLED_DIR)
        set (VCPKG_INSTALLED_DIR "${CMAKE_CURRENT_LIST_DIR}/installed" CACHE PATH "This variable sets the location where libraries will be installed and consumed from." FORCE)
    endif ()
    if (NOT DEFINED VCPKG_OVERLAY_PORTS)
        set (VCPKG_OVERLAY_PORTS "${CMAKE_CURRENT_LIST_DIR}/ports" CACHE PATH "" FORCE)
    endif ()
    if (NOT DEFINED VCPKG_OVERLAY_TRIPLETS)
        set (VCPKG_OVERLAY_TRIPLETS "${CMAKE_CURRENT_LIST_DIR}/triplets" CACHE PATH "" FORCE)
    endif ()
    if (NOT DEFINED VCPKG_TRACE_FIND_PACKAGE)
        option (VCPKG_TRACE_FIND_PACKAGE "When set to 'ON', print every call to 'find_package()'. Nested calls (e.g. via 'find_dependency()') are indented according to nesting depth." ON)
    endif ()


    # VCPKG toolchain options.
    option (VCPKG_VERBOSE "Enables messages from the VCPKG toolchain for debugging purposes." ON)
    option (VCPKG_APPLOCAL_DEPS "Automatically copy dependencies into the output directory for executables." ON)
    option (X_VCPKG_APPLOCAL_DEPS_SERIALIZED "(experimental) Add USES_TERMINAL to VCPKG_APPLOCAL_DEPS to force serialization." OFF)
    option (X_VCPKG_APPLOCAL_DEPS_INSTALL "(experimental) Automatically copy dependencies into the install target directory for executables. Requires CMake 3.14." OFF)
    #option (VCPKG_PREFER_SYSTEM_LIBS "Appends the vcpkg paths to CMAKE_PREFIX_PATH, CMAKE_LIBRARY_PATH and CMAKE_FIND_ROOT_PATH so that vcpkg libraries/packages are found after toolchain/system libraries/packages." ON)

    if (NOT DEFINED VCPKG_MANIFEST_DIR)
        set (VCPKG_MANIFEST_DIR "${CMAKE_CURRENT_LIST_DIR}" CACHE PATH "The path to the vcpkg manifest directory." FORCE)
    endif ()
    if (NOT DEFINED VCPKG_MANIFEST_FEATURES)
        set (VCPKG_MANIFEST_FEATURES "node-development" "cmrc" CACHE STRING "This variable can be set to a list of features to activate when installing your manifest. For example, features can be used by projects to control building with additional dependencies.")
    endif ()
    option (VCPKG_MANIFEST_NO_DEFAULT_FEATURES "This variable controls activation of default features in additon to those listed in 'VCPKG_MANIFEST_FEATURES'. If set to 'ON', default features will not be automatically activated." ON)
    option (VCPKG_MANIFEST_MODE "Use manifest mode, as opposed to classic mode." ON)
    option (VCPKG_MANIFEST_INSTALL "This variable controls whether vcpkg will be automatically run to install your dependencies during your configure step. Defaults to 'ON' if 'VCPKG_MANIFEST_MODE' is 'ON'." "${VCPKG_MANIFEST_MODE}")
    if (NOT DEFINED VCPKG_INSTALL_OPTIONS)
        set (VCPKG_INSTALL_OPTIONS
            # Clean buildtrees, packages and downloads after building each package.
            # "--clean-after-build"
            # # Clean buildtrees after building each package.
            # "--clean-buildtrees-after-build"
            # # Clean downloads after building each package.
            "--clean-downloads-after-build"
            # # Clean packages after building each package.
            # "--clean-packages-after-build"
            CACHE
            STRING
            "This variable can be set to a list of additional command line parameters to pass to the vcpkg tool during automatic installation."
            FORCE
        )
    endif ()
    if (NOT DEFINED VCPKG_FEATURE_FLAGS)
        set (VCPKG_FEATURE_FLAGS
        ""
            # # Specifies the vcpkg root folder.
            # "--vcpkg-root=${VCPKG_ROOT}"
            # # Specifies the target architecture triplet.
            # "--triplet=${VCPKG_DEFAULT_TRIPLET}"
            # # Specifies the host triplet.
            # "--host-triplet=${VCPKG_DEFAULT_HOST_TRIPLET}"
            # # Adds a source for Binary Caching. This option can be specified multiple times.
            # "--binarysource=clear;default,readwrite"
            # # Specifies where downloaded tools and source code archives should be kept.
            # "--downloads-root=${VCPKG_ROOT}/downloads"
            # # Experimental: Specifies the temporary path to store intermediate build files, such as objects or unpacked source code.
            # "--x-buildtrees-root=${VCPKG_ROOT}/buildtrees"
            # # Experimental: Specifies the path to lay out installed packages.
            # "--x-install-root=${VCPKG_INSTALLED_DIR}"
            # # Experimental: Specifies the directory containing 'vcpkg.json'.
            # "--x-manifest-root=${VCPKG_ROOT}"
            # # Experimental: Specifies the temporary path to stage intermediate package files before final install.
            # "--x-packages-root=${VCPKG_ROOT}/packages"
            # # Specifies a directory containing overlay ports. This option can be specified multiple times to add multiple directories; ports will resolve to the first match.
            # "--overlay-ports=${VCPKG_ROOT}/ports"
            # # Specifies a directory containing overlay triplets. This option can be specified multiple times to add multiple directories; triplets will resolve to the first match by name.
            # "--overlay-triplets=${VCPKG_ROOT}/triplets"
            CACHE STRING "This variable can be set to a list of additional command line parameters to pass to the vcpkg tool during automatic installation to opt in to experimental behaviour."
        )
    endif ()

    # VCPKG toolchain variables.
    if (NOT DEFINED VCPKG_BUILD_TYPE)
        set (VCPKG_BUILD_TYPE "${CMAKE_BUILD_TYPE}" CACHE STRING "You can set this value to 'release' to only build release versions of the ports. By default this value is empty and release and debug versions of a port are built.")
    endif ()
    if (NOT DEFINED VCPKG_TARGET_ARCHITECTURE)
        set (VCPKG_TARGET_ARCHITECTURE "x64" CACHE STRING "Specifies the target machine arhitecture. Valid options are 'x86', 'x64', 'arm', 'arm64', and 'wasm32'.")
    endif ()
    if (NOT DEFINED VCPKG_LIBRARY_LINKAGE)
        set (VCPKG_LIBRARY_LINKAGE "dynamic" CACHE STRING "Specifies the preferred library linkage. Valid options are 'dynamic' and 'static'. Libraries can ignore this setting if they do not support the preferred linkage type.")
    endif ()
    if (NOT DEFINED VCPKG_CRT_LINKAGE)
        set (VCPKG_CRT_LINKAGE "${VCPKG_LIBRARY_LINKAGE}" CACHE STRING "Specifies the desired CRT linkage (for MSVC). Valid options are 'dynamic' and 'static'.")
    endif ()

    if (NOT DEFINED VCPKG_CMAKE_SYSTEM_NAME)
        set (VCPKG_CMAKE_SYSTEM_NAME "${CMAKE_SYSTEM_NAME}" CACHE STRING "Specifies the target platform. Valid options include any CMake system name, such as: Empty (Windows Desktop for legacy reasons); 'WindowsStore' (Universal Windows Platform); 'MinGW' (Minimalist GNU for Windows); 'Darwin' (Mac OSX); 'iOS' (iOS); 'Linux' (Linux); 'Emscripten' (WebAssembly).")
    endif ()
    if (NOT DEFINED VCPKG_CMAKE_SYSTEM_VERSION)
        set (VCPKG_CMAKE_SYSTEM_VERSION "${CMAKE_SYSTEM_VERSION}" CACHE STRING "Specifies the target platform system version. This field is optional and, if present, will be passed in as 'CMAKE_SYSTEM_VERSION'.")
    endif ()
    if (NOT DEFINED VCPKG_CMAKE_CONFIGURE_OPTIONS)
        set (VCPKG_CMAKE_CONFIGURE_OPTIONS "" CACHE STRING "Set additional CMake configure options that are appended to the configure command (in 'vcpkg_cmake_configure').")
    endif ()
    if (NOT DEFINED VCPKG_CMAKE_CONFIGURE_OPTIONS_DEBUG)
        set (VCPKG_CMAKE_CONFIGURE_OPTIONS_DEBUG "" CACHE STRING "Set additional CMake configure options that are appended to the configure command (in 'vcpkg_cmake_configure').")
    endif ()
    if (NOT DEFINED VCPKG_CMAKE_CONFIGURE_OPTIONS_RELEASE)
        set (VCPKG_CMAKE_CONFIGURE_OPTIONS_RELEASE "" CACHE STRING "Set additional CMake configure options that are appended to the configure command (in 'vcpkg_cmake_configure').")
    endif ()

    if (NOT DEFINED VCPKG_MAKE_CONFIGURE_OPTIONS)
        set (VCPKG_MAKE_CONFIGURE_OPTIONS "" CACHE STRING "Set additional automake /autoconf configure options that are appended to the configure command (in 'vcpkg_configure_make').")
    endif ()
    if (NOT DEFINED VCPKG_MAKE_CONFIGURE_OPTIONS_DEBUG)
        set (VCPKG_MAKE_CONFIGURE_OPTIONS_DEBUG "" CACHE STRING "Set additional automake /autoconf configure options that are appended to the configure command (in 'vcpkg_configure_make').")
    endif ()
    if (NOT DEFINED VCPKG_MAKE_CONFIGURE_OPTIONS_RELEASE)
        set (VCPKG_MAKE_CONFIGURE_OPTIONS_RELEASE "" CACHE STRING "Set additional automake /autoconf configure options that are appended to the configure command (in 'vcpkg_configure_make').")
    endif ()


    option (VCPKG_DISABLE_COMPILER_TRACKING "When this option is set to 'TRUE', 'ON', or '1', the compiler will not be tracked as part of the package abis. This will cause Binary Caching to reuse builds from older or newer compilers.")

    if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
        # Windows-specific variables and options
        option (VCPKG_LOAD_VCVARS_ENV "Determines whether vcpkg will search for and use an instance of Visual Studio as part of the triplet environment." ON)
        if (NOT DEFINED VCPKG_ENV_PASSTHROUGH)
            set (VCPKG_ENV_PASSTHROUGH "" CACHE STRING "Instructs vcpkg to allow additional environment variables into the build process. See also 'vcpkg env' on the command line for how you can inspect the precise environment that will be used.")
        endif ()
        if (NOT DEFINED VCPKG_ENV_PASSTHROUGH_UNTRACKED)
            set (VCPKG_ENV_PASSTHROUGH_UNTRACKED "" CACHE STRING "Instructs vcpkg to allow additional environment variables into the build process without abi tracking.")
        endif ()
    endif ()

    if (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
        option (VCPKG_FIXUP_ELF_RPATH "When this option is set to (true|1|on), vcpkg will add '$ORIGIN' and '$ORIGIN/<path_relative_to_lib>' to the 'RUNPATH' header of executables and shared libraries. This allows packages to be relocated on Linux." ON)
    endif ()

    if (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
        if (NOT DEFINED VCPKG_INSTALL_NAME_DIR)
            set (VCPKG_INSTALL_NAME_DIR "@rpath" CACHE STRING "Sets the install name used when building macOS dynamic libraries. Default is '@rpath'.")
        endif ()
    endif ()



    if (NOT DEFINED VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
        if (NOT DEFINED VCPKG_LINKER_FLAGS)
            set (VCPKG_LINKER_FLAGS "$ENV{LDFLAGS}" CACHE STRING "Sets additional linker flags to be used when building dynamic libraries and executables in the absence of 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()
        if (NOT DEFINED VCPKG_LINKER_FLAGS_DEBUG)
            set (VCPKG_LINKER_FLAGS_DEBUG "" CACHE STRING "Sets additional linker flags to be used when building dynamic libraries and executables in the absence of 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()
        if (NOT DEFINED VCPKG_LINKER_FLAGS_RELEASE)
            set (VCPKG_LINKER_FLAGS_RELEASE "" CACHE STRING "Sets additional linker flags to be used when building dynamic libraries and executables in the absence of 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()

        if (NOT DEFINED VCPKG_C_FLAGS)
            set (VCPKG_C_FLAGS "$ENV{CFLAGS}" CACHE STRING "Sets additional compiler flags to be used when not using 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()
        if (NOT DEFINED VCPKG_C_FLAGS_DEBUG)
            set (VCPKG_C_FLAGS_DEBUG "" CACHE STRING "Sets additional compiler flags to be used when not using 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()
        if (NOT DEFINED VCPKG_C_FLAGS_RELEASE)
            set (VCPKG_C_FLAGS_RELEASE "" CACHE STRING "Sets additional compiler flags to be used when not using 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()

        if (NOT DEFINED VCPKG_CXX_FLAGS)
            set (VCPKG_CXX_FLAGS "$ENV{CXXFLAGS}" CACHE STRING "Sets additional compiler flags to be used when not using 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()
        if (NOT DEFINED VCPKG_CXX_FLAGS_DEBUG)
            set (VCPKG_CXX_FLAGS_DEBUG "" CACHE STRING "Sets additional compiler flags to be used when not using 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()
        if (NOT DEFINED VCPKG_CXX_FLAGS_RELEASE)
            set (VCPKG_CXX_FLAGS_RELEASE "" CACHE STRING "Sets additional compiler flags to be used when not using 'VCPKG_CHAINLOAD_TOOLCHAIN_FILE'.")
        endif ()

    endif ()


    if (USE_PROJECT_VCPKG)

        set (CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/buildsystems/vcpkg.cmake")
        # set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "" CACHE FILEPATH "Specifies an alternate CMake Toolchain file to use. This (if set) will override all other compiler detection logic. By default, a toolchain file is selected from 'scripts/toolchains/' appropriate to the platform.")
        if (NOT DEFINED VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
            if (CMAKE_HOST_SYSTEM_NAME MATCHES "Windows" OR "")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/windows.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Linux")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/linux.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Darwin")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/osx.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "MinGW")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/mingw.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "iOS")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/ios.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Android")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/android.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "FreeBSD")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/freebsd.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "OpenBSD")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/openbsd.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "WindowsStore")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/uwp.cmake")
            elseif (CMAKE_HOST_SYSTEM_NAME MATCHES "Xbox")
                set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/openbsd.cmake")
            else ()
                unset (VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
                message (WARNING "No Toolchain file available to match this CMAKE_HOST_SYSTEM_NAME...")
            endif ()
        endif()
        set (VCPKG_MANIFEST_INSTALL ON)
        set (VCPKG_MANIFEST_MODE ON)
        set (VCPKG_MANIFEST_DIR "${CMAKE_CURRENT_LIST_DIR}")
    endif ()


    # find_program (VCPKG_EXECUTABLE
    #     NAMES "vcpkg" "vcpkg.exe"
    #     PATHS "${CMAKE_CURRENT_LIST_DIR}"
    #     NO_DEFAULT_PATH
    #     NO_PACKAGE_ROOT_PATH
    #     NO_CMAKE_PATH
    #     NO_CMAKE_ENVIRONMENT_PATH
    #     NO_SYSTEM_ENVIRONMENT_PATH
    #     NO_CMAKE_SYSTEM_PATH
    # )
    # if (NOT VCPKG_EXECUTABLE)
    #     if (NOT CMAKE_TOOLCHAIN_FILE)
    #         if (WIN32)
    #             set (CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/windows.cmake")
    #         elseif (UNIX AND NOT APPLE)
    #             set (CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/linux.cmake")
    #         elseif (APPLE)
    #             set (CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/osx.cmake")
    #         endif ()
    #     endif ()
    #     add_subdirectory(toolsrc)
    #     return()
    # else ()
    #     # if (NOT CMAKE_TOOLCHAIN_FILE)
    #     set (CMAKE_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/buildsystems/vcpkg.cmake")
    #     # endif ()
    #     if (NOT VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
    #         if (WIN32)
    #             set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/windows.cmake")
    #         elseif (UNIX AND NOT APPLE)
    #             set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/linux.cmake")
    #         elseif (APPLE)
    #             set (VCPKG_CHAINLOAD_TOOLCHAIN_FILE "${CMAKE_CURRENT_LIST_DIR}/scripts/toolchains/osx.cmake")
    #         endif ()
    #     endif ()
    # endif ()

    message (STATUS "...loaded 'vcpkg-settings.cmake'.")

endmacro ()
