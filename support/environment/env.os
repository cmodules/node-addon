#!/usr/bin/env sh

# @file CMake Operating System environment variables cache
#
# @brief cmakeDefined build and configuration variables.
#
# Values wrapped in 'at' symbols are computed by CMake
# at configure time.
#
# Values wrapped in '${}' symbols are *not* computed
# by CMake at configure time, allowing for comments.


@ENV_VARS_ALL@
