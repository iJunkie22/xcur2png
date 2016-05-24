cmake_minimum_required(VERSION 3.3)
project(xcur2png)

set(ENV{LIBPREFIX} "/opt/local")
set(ENV{CPATH} "${LIBPREFIX}/include")
set(ENV{CPPFLAGS} "-I${LIBPREFIX}/include")
set(ENV{LDFLAGS} "-L${LIBPREFIX}/lib")
set(ENV{CFLAGS} "-O3 -Wall")
set(ENV{CXXFLAGS} "${CFLAGS}")
#set(CMAKE_C_FLAGS "-03 -Wall")

set(LIBPREFIX "/opt/local")
include_directories("/opt/local/include")
link_directories("/opt/local/lib")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} $ENV{CXXFLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L/opt/local/lib")
set(MY_LIB_PNG "/opt/local/lib/libpng.dylib" CACHE FILEPATH "moo")
set(SOURCE_FILES
    config.h
    xcur2png.c)

find_library(XCURSOR_LIB xcursor)
find_library(LIB_PNG "libpng")
link_libraries("${XCURSOR_LIB}" "${MY_LIB_PNG}")

add_executable(xcur2png ${SOURCE_FILES})

