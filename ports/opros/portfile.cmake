vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF 0e1653aff0536fd1f46eaedbc40c6b38ecf103de
    SHA512 9d95e1d08105ce5f9ebd8e620190dcc4eaac12fffcb7ad2f7f7b229c890e86ddcc4d549b54c0c303583322d93a4b52945d5188d3b24ee1405639a1efea451faf
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}/build/cmake"
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup()

# Delete the include directory from the debug installation to prevent overlap.
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Install the LICENSE file to the package's share directory and rename it to copyright.
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)

# Copy the usage instruction file to the package's share directory.
configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
