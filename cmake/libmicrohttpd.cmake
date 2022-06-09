# SPDX-FileCopyrightText: 2022 Alexander Dahl <post@lespocky.de>
# SPDX-License-Identifier: BSD-2-Clause
set(MHD_VER 0.9.75 CACHE STRING "libmicrohttpd version")
set(MHD_MD5 aff64581937b53f3a23b05216ad2cd02 CACHE STRING "libmicrohttpd tarball md5sum")

ExternalProject_Add(libmicrohttpd
	PREFIX sysroot-prefix
	URL https://ftpmirror.gnu.org/libmicrohttpd/libmicrohttpd-${MHD_VER}.tar.gz
	URL_HASH MD5=${MHD_MD5}
	CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
		--disable-examples
	TEST_COMMAND make check
	TEST_EXCLUDE_FROM_MAIN 1
	STEP_TARGETS install
)
