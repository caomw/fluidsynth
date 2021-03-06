# origin: http://www.cmake.org/Wiki/CMakeMacroLibtoolFile

MACRO(GET_TARGET_PROPERTY_WITH_DEFAULT _variable _target _property _default_value)
  GET_TARGET_PROPERTY (${_variable} ${_target} ${_property})
  IF (${_variable} MATCHES ".*NOTFOUND$")
    SET (${_variable} ${_default_value})
  ENDIF (${_variable} MATCHES ".*NOTFOUND$")
ENDMACRO (GET_TARGET_PROPERTY_WITH_DEFAULT)

MACRO(CREATE_LIBTOOL_FILE _target _install_DIR)
  GET_TARGET_PROPERTY(_target_location ${_target} LOCATION)
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_static_lib ${_target} STATIC_LIB "")
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_dependency_libs ${_target} LT_DEPENDENCY_LIBS "")
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_current ${_target} LT_VERSION_CURRENT 0)
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_age ${_target} LT_VERSION_AGE 0)
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_revision ${_target} LT_VERSION_REVISION 0)
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_installed ${_target} LT_INSTALLED yes)
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_shouldnotlink ${_target} LT_SHOULDNOTLINK yes)
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_dlopen ${_target} LT_DLOPEN "")
  GET_TARGET_PROPERTY_WITH_DEFAULT(_target_dlpreopen ${_target} LT_DLPREOPEN "")
  GET_FILENAME_COMPONENT(_laname ${_target_location} NAME_WE)
  GET_FILENAME_COMPONENT(_soname ${_target_location} NAME)
  SET(_laname ${_laname}.la)
  SET(_laname_file "${CMAKE_CURRENT_BINARY_DIR}/${_laname}")
  FILE(WRITE ${_laname_file} "# ${_laname} - a libtool library file, generated by cmake \n")
  FILE(APPEND ${_laname_file} "# The name that we can dlopen(3).\n")
  FILE(APPEND ${_laname_file} "dlname='${_soname}'\n")
  FILE(APPEND ${_laname_file} "# Names of this library\n")
  FILE(APPEND ${_laname_file} "library_names='${_soname}.${_target_current}.${_target_age}.${_target_revision} ${_soname}.${_target_current} ${_soname}'\n")
  FILE(APPEND ${_laname_file} "# The name of the static archive\n")
  FILE(APPEND ${_laname_file} "old_library='${_target_static_lib}'\n")
  FILE(APPEND ${_laname_file} "# Libraries that this one depends upon.\n")
  FILE(APPEND ${_laname_file} "dependency_libs='${_target_dependency_libs}'\n")
  FILE(APPEND ${_laname_file} "# Version information.\n")
  FILE(APPEND ${_laname_file} "current=${_target_current}\n")
  FILE(APPEND ${_laname_file} "age=${_target_age}\n")
  FILE(APPEND ${_laname_file} "revision=${_target_revision}\n")
  FILE(APPEND ${_laname_file} "# Is this an already installed library?\n")
  FILE(APPEND ${_laname_file} "installed=${_target_installed}\n")
  FILE(APPEND ${_laname_file} "# Should we warn about portability when linking against -modules?\n")
  FILE(APPEND ${_laname_file} "shouldnotlink=${_target_shouldnotlink}\n")
  FILE(APPEND ${_laname_file} "# Files to dlopen/dlpreopen\n")
  FILE(APPEND ${_laname_file} "dlopen='${_target_dlopen}'\n")
  FILE(APPEND ${_laname_file} "dlpreopen='${_target_dlpreopen}'\n")
  FILE(APPEND ${_laname_file} "# Directory that this library needs to be installed in:\n")
  FILE(APPEND ${_laname_file} "libdir='${CMAKE_INSTALL_PREFIX}/${_install_DIR}'\n")
  INSTALL(FILES ${_laname_file} DESTINATION ${_install_DIR})
ENDMACRO(CREATE_LIBTOOL_FILE)
