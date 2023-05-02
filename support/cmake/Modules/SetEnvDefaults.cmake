function(env_defaults)

    set(NODE_RUNTIME "node")

    # Ensure a valid build type is set
    if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)

        if(PROJECT_IS_TOP_LEVEL)
            set(DEFAULT_BUILD_TYPE "Debug" CACHE STRING "The default CMake build type, if none specified.")
        else()
            message(WARNING "Default build type is not set (CMAKE_BUILD_TYPE)")
        endif()

        message(STATUS "Setting build type to '${DEFAULT_BUILD_TYPE}' as none was specified.")
        set(CMAKE_BUILD_TYPE "${DEFAULT_BUILD_TYPE}" CACHE STRING "Choose the type of build." FORCE)
        set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")

    endif()

    # Ensure a valid NodeJS environment type is set
    if (NOT NODE_ENV)

        if(PROJECT_IS_TOP_LEVEL)
            set(DEFAULT_NODE_ENV "development" CACHE STRING "The default NodeJS environment type, if none specified.")
        else()
        endif ()

        set(NODE_ENV "${DEFAULT_NODE_ENV}" CACHE STRING "Choose the type of NodeJS environment." FORCE)
        set_property(CACHE NODE_ENV PROPERTY STRINGS "test" "development" "production" "deployment")

    endif ()

endfunction()

env_defaults()
