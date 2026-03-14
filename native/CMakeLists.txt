cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    mochibot
    VERSION 0.1.0
    DESCRIPTION "Short description"
    HOMEPAGE_URL "https://example.com/"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(
    mochibot_mochibot
    source/mochibot.cpp
)
add_library(mochibot::mochibot ALIAS mochibot_mochibot)

include(GenerateExportHeader)
generate_export_header(
    mochibot_mochibot
    BASE_NAME mochibot
    EXPORT_FILE_NAME export/mochibot/mochibot_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
  target_compile_definitions(mochibot_mochibot PUBLIC MOCHIBOT_STATIC_DEFINE)
endif()

set_target_properties(
    mochibot_mochibot PROPERTIES
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN YES
    VERSION "${PROJECT_VERSION}"
    SOVERSION "${PROJECT_VERSION_MAJOR}"
    EXPORT_NAME mochibot
    OUTPUT_NAME mochibot
)

target_include_directories(
    mochibot_mochibot ${warning_guard}
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    mochibot_mochibot SYSTEM
    PUBLIC
    "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(mochibot_mochibot PUBLIC cxx_std_20)

find_package(fmt REQUIRED)
target_link_libraries(mochibot_mochibot PRIVATE fmt::fmt)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
  include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT mochibot_DEVELOPER_MODE)
  return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
  message(
      AUTHOR_WARNING
      "Developer mode is intended for developers of mochibot"
  )
endif()

include(cmake/dev-mode.cmake)
