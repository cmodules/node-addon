# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/bind
    REF boost-1.82.0
    SHA512 f816e3421e34e6f185708ce1cc0590a634f893493fd62d1d75a51e98b84eadf75af55301d1ae79e39f62ae5e81b5fc8f3366d5a6745e75ecfe5cdf770b57de41
    HEAD_REF master
)

include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})