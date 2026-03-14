if(PROJECT_IS_TOP_LEVEL)
  set(
      CMAKE_INSTALL_INCLUDEDIR "include/mochibot-${PROJECT_VERSION}"
      CACHE STRING ""
  )
  set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
# should match the name of variable set in the install-config.cmake script
set(package mochibot)

install(
    DIRECTORY
    include/
    "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT mochibot_Development
)

install(
    TARGETS mochibot_mochibot
    EXPORT mochibotTargets
    RUNTIME #
    COMPONENT mochibot_Runtime
    LIBRARY #
    COMPONENT mochibot_Runtime
    NAMELINK_COMPONENT mochibot_Development
    ARCHIVE #
    COMPONENT mochibot_Development
    INCLUDES #
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(
    mochibot_INSTALL_CMAKEDIR "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING "CMake package config location relative to the install prefix"
)
set_property(CACHE mochibot_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(mochibot_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${mochibot_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT mochibot_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${mochibot_INSTALL_CMAKEDIR}"
    COMPONENT mochibot_Development
)

install(
    EXPORT mochibotTargets
    NAMESPACE mochibot::
    DESTINATION "${mochibot_INSTALL_CMAKEDIR}"
    COMPONENT mochibot_Development
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
