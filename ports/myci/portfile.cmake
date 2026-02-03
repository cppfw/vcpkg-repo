# myci doesn't install any header files
set(VCPKG_POLICY_EMPTY_INCLUDE_FOLDER enabled)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF aa55386a521a48773490cc4fe39796193358ce04
    SHA512 93e3e6fdd21f02d68863563d68bb4fb986ebf66dd30eec233cee81255cd12abdad9d505bd4a4a23f6fd0eb5cd9e1f2639dc1fea034b16ede98f16b048fdbe530
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
