# SPDX-FileCopyrightText: 2022 Alexander Dahl <post@lespocky.de>
# SPDX-License-Identifier: BSD-2-Clause
cmake_minimum_required(VERSION 3.1)
project(glowing-tribble-build)

include(CMakePrintHelpers)

## external
# extract cmake cflags and set our own variables to pass over to config.site template
if(CMAKE_BUILD_TYPE)
	string(TOUPPER ${CMAKE_BUILD_TYPE} BUILD_TYPE_UC)
endif()
set(CFLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${BUILD_TYPE_UC}}")
cmake_print_variables(CFLAGS)
set(CXXFLAGS "${CMAKE_CXX_FLAGS} ${CMAKE_CXX_FLAGS_${BUILD_TYPE_UC}}")
cmake_print_variables(CXXFLAGS)

include(ExternalProject)
configure_file(
	config.site.in
	"${PROJECT_BINARY_DIR}/sysroot-prefix/share/config.site"
	@ONLY
)
include("cmake/libmicrohttpd.cmake")
include("cmake/libhttpserver.cmake")
set(CMAKE_PREFIX_PATH "${PROJECT_BINARY_DIR}/sysroot-prefix")
cmake_print_variables(CMAKE_PREFIX_PATH)

## application
# this is optional here, because you need to build libhttpserver first
# without anything depending on it (especially pkg_check_modules() fails).
# switch this on, if libhttpserver was built once.
option(GLOWING_TRIBBLE_BUILD_APP "build the app or not" OFF)
if(GLOWING_TRIBBLE_BUILD_APP)
	add_subdirectory("glowing-tribble")
	add_dependencies(hello_world libhttpserver-install)
else()
	ExternalProject_Get_Property(libhttpserver INSTALL_DIR)
	if(EXISTS "${INSTALL_DIR}/lib/pkgconfig/libhttpserver.pc")
		message("You can enable 'GLOWING_TRIBBLE_BUILD_APP' now!")
	else()
		message("Please build once before enabling 'GLOWING_TRIBBLE_BUILD_APP'!")
	endif()
endif()
