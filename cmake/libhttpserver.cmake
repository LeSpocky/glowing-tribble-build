# SPDX-FileCopyrightText: 2022 Alexander Dahl <post@lespocky.de>
# SPDX-License-Identifier: BSD-2-Clause
ExternalProject_Add(libhttpserver
	DEPENDS libmicrohttpd
	PREFIX sysroot-prefix
	GIT_REPOSITORY https://github.com/etr/libhttpserver.git
	GIT_TAG master
	UPDATE_DISCONNECTED 1
	CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
		--$<IF:$<CONFIG:DEBUG>,enable,disable>-debug --disable-examples
	TEST_COMMAND make check
	TEST_EXCLUDE_FROM_MAIN 1
	STEP_TARGETS update install test
)

ExternalProject_Get_Property(libhttpserver SOURCE_DIR)
ExternalProject_Add_Step(libhttpserver bootstrap
	COMMAND				./bootstrap
	DEPENDEES			update
	DEPENDERS			configure
	BYPRODUCTS			<SOURCE_DIR>/configure
	WORKING_DIRECTORY	<SOURCE_DIR>
)
