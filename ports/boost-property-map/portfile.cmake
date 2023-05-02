# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/property_map
    REF boost-1.82.0
    SHA512 ca6507ef4ba7ec671f8b217a94a5b4b3cd07c278752c3a6a5501035cf106ac2a230114f196ea3e96edfe36ecf5e73cfbbfb1ac322af62fda35320d4ea8c1ad54
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})