# myci doesn't install any header files
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF 72dbdc04e91660360d16a03922a491c90cd90057
    SHA512 3369246848d2ce83cc06149ca06f9938f66615cf1d4a7f3c3728c9e500d755ad48011ec7be471db4ddfb8b8c06c43e56faec210935302d8f82e64de30c3d5ee0
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
