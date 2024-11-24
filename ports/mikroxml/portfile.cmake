vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF 27b63948b3e6929f6489fce252644f4e97426898
    SHA512 7058d9a348c3c94aba502ecf1c3b97c6508f44371263d8f72cd21db0aa1d4283779e90cf8de504a8510fec7d4e25c6b30f26d1dc6641cc13b85b2b3cd01b271d
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
