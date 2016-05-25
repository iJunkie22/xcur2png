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

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} $ENV{CXXFLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L/opt/local/lib")

function(initmacports)
    include_directories("/opt/local/include")
    link_directories("/opt/local/lib")
    set(MACPORTS_LIBS "" PARENT_SCOPE)
    set(MACPORTS_DEPS "" PARENT_SCOPE)
endfunction(initmacports)

function(macportlookup result portname)
    execute_process(
            COMMAND echo "${portname}"
            COMMAND tr -d "*"
            OUTPUT_VARIABLE safe_portname OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    execute_process(
            COMMAND port echo "${portname}"
            OUTPUT_VARIABLE echoed_pn OUTPUT_STRIP_TRAILING_WHITESPACE
    )
        message(WARNING "${safe_portname}")
    execute_process(
            COMMAND port contents "${portname}"
            COMMAND grep -m1 -iE "${safe_portname}.dylib$"
            COMMAND sed "s:^ *::"
            OUTPUT_VARIABLE qresult OUTPUT_STRIP_TRAILING_WHITESPACE
    )
        message(WARNING "${qresult}")
        set(${result} "${qresult}" CACHE FILEPATH "macport port ${portname}")
    set(MACPORTS_LIBS ${MACPORTS_LIBS} ${qresult} PARENT_SCOPE)
    set(MACPORTS_DEPS ${MACPORTS_DEPS} ${echoed_pn} PARENT_SCOPE)
endfunction(macportlookup)


macro(linkmacports)
    link_libraries(${MACPORTS_LIBS})
    message(WARNING "linked ${MACPORTS_LIBS}")
    message(WARNING "this build used the ports: ${MACPORTS_DEPS}")
    set(MACPORTS_DEPS ${MACPORTS_DEPS} CACHE FILEPATH "used ports" FORCE)
endmacro(linkmacports)

initmacports()
macportlookup(MY_LIB_PNG libpng)
macportlookup(XCURSOR_LIB2 "*xcursor")
set(SOURCE_FILES
    config.h
    xcur2png.c)

#find_library(XCURSOR_LIB xcursor)
#find_library(LIB_PNG "libpng")
#link_libraries("${XCURSOR_LIB}" "${MY_LIB_PNG}")
linkmacports()
add_executable(xcur2png ${SOURCE_FILES})

