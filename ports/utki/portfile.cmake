vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF d2b7bd5323aae62cb2b2e7abaae3fb02c28a586e
    SHA512 4a06badfa55a46e8cf44957aaf3dbd1f4f5721fb904bc58f4bf89050f3f35cb90f839ccba684e08102d6595de84c22bb6ca7b27228ba1eec3afcedf9e8c0162a
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
