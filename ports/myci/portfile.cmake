# myci doesn't install any header files
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF 86afbda3c7bb6fa8eb1d1b6b83667c5d367f8d08
    SHA512 5f0f487269667c516e9323337c25e8501b47fc6d9769010d2cf6c7c6002e1c1541cede7529abfe69e444f8a7c5eed3ab603ca6afa0df91d93611404adf2e0b97
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/build/cmake"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()

# Delete the debug directory since the package doesn't provide debug files.
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

# Install the LICENSE file to the package's share directory and rename it to copyright.
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

# Copy the usage instruction file to the package's share directory.
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
