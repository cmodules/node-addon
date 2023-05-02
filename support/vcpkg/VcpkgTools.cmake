# CMake requirements.
cmake_minimum_required (VERSION 3.9...3.26.3)

# Cmake-js requirements
cmake_policy (SET CMP0011 NEW)

# Required vcpkg build output locations
# Header files: include/
# Release .lib, .a, and .so files: lib/ or lib/manual-link/
# Release .dll files: bin/
# Release .pc files: lib/pkgconfig/ or share/pkgconfig/
# Debug .lib, .a, and .so files: debug/lib/ or debug/lib/manual-link/
# Debug .dll files: debug/bin/
# Debug .pc files: debug/lib/pkgconfig/ or debug/share/pkgconfig/
# Tools: tools/<port>/

include ("${VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake")

# VCPKG Cache variables
VCPKG_TARGET_TRIPLET
VCPKG_HOST_TRIPLET
VCPKG_INSTALLED_DIR
VCPKG_MANIFEST_MODE
VCPKG_MANIFEST_DIR
VCPKG_MANIFEST_INSTALL
VCPKG_BOOTSTRAP_OPTIONS
VCPKG_OVERLAY_TRIPLETS
VCPKG_OVERLAY_PORTS
VCPKG_MANIFEST_FEATURES
VCPKG_MANIFEST_NO_DEFAULT_FEATURES
VCPKG_INSTALL_OPTIONS
VCPKG_PREFER_SYSTEM_LIBS
VCPKG_FEATURE_FLAGS
VCPKG_TRACE_FIND_PACKAGE


set (CXXFLAGS "-I${pwd}/installed/x64-linux/include:${CXXFLAGS}")
set (CFLAGS "-I${pwd}/installed/x64-linux/include:${CFLAGS}")
set (LDFLAGS "-L${pwd}/installed/x64-linux/lib:${LDFLAGS}")
set (PKG_CONFIG_PATH "${pwd}/installed/x64-linux/lib/pkgconfig:${pwd}/installed/x64-linux/share/pkgconfig:${PKG_CONFIG_PATH}")
