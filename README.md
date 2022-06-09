<!--
SPDX-FileCopyrightText: 2022 Alexander Dahl <post@lespocky.de>
SPDX-License-Identifier: 0BSD
-->

# glowing-tribble-build

This is a [CMake](https://cmake.org/) superbuild project to build the
[glowing-tribble](https://github.com/LeSpocky/glowing-tribble) example.
The *glowing-tribble* project is included as a
[Git](https://git-scm.com/) submodule.

To build both [libhttpserver](https://github.com/etr/libhttpserver) and
[libmicrohttpd](https://www.gnu.org/software/libmicrohttpd/) within this
superbuild project (using CMake's *ExternalProject* feature), it uses a
shared *config.site* file for autotools.
See my blog post ["Building multiple inter-dependent autotools based
projects"](http://blog.antiblau.de/2022/04/08/building-multiple-inter-dependent-autotools-based-projects/)
for a longer explanation on how that works.

For *pkg-config* being able to pick up libhttpserver build artifacts,
you need to build in two runs.
On the first run set CMake variable *GLOWING_TRIBBLE_BUILD_APP* to *OFF*
(default) and build once.
This should build both libmicrohttpd and libhttpserver.
Before subsequent runs set *GLOWING_TRIBBLE_BUILD_APP* to *ON*.
