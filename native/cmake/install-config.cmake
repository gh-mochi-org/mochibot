set(mochibot_FOUND YES)

include(CMakeFindDependencyMacro)
find_dependency(fmt)

if(mochibot_FOUND)
  include("${CMAKE_CURRENT_LIST_DIR}/mochibotTargets.cmake")
endif()
