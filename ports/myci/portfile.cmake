# myci doesn't install any header files
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF 8a9dae7ba8cf55d9522c95b20f3164b242b4f8ab
    SHA512 0153014373bb0a5586b1060eee938cef15bc90a67f280b9bc5829befbba839b8869992804a4de62c1856d5222e467017fed0b276196aa8f2f7c8aa826ffb2beb
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/build/cmake"
    OPTIONS
        -D IS_VCPKG_PORT_BUILD=True
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()

# Delete the debug directory since the package doesn't provide debug files.
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Install the LICENSE file to the package's share directory and rename it to copyright.
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

# Copy the usage instruction file to the package's share directory.
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
