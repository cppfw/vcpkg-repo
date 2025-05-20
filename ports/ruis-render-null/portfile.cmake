vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO cppfw/${PORT}
    REF dadd2a26e37fffa4e22ad84fb83e7c8af0689596
    SHA512 e499db5b6ac695321cb11802a72d63d3f8a362d1b60bc5414b38455d54b43f39b7b44ada32f0e21f5ba6c80752ec67dac6b63d19d7a8f5960788d6a61994c71e
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
