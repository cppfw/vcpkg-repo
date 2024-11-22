vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF 22f64ce3c7d423409ba020c8bcf8984e7c9ea6af
    SHA512 61626355f43e1eb25dc0d3bb7b9fc2d15e1c7cb0f308d59bd8fcb6e295f3357c7f5275fecd1dbf9d8d34af4591a528f7581e2b63dfc138420cf9cd5390fa7a9a
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/cmake"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()

# Delete the include directory from the debug installation to prevent overlap.
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Install the LICENSE file to the package's share directory and rename it to copyright.
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

# Copy the usage instruction file to the package's share directory.
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
