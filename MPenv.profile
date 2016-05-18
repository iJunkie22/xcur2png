
export LIBPREFIX="/opt/local"
#  automake seach path
export CPATH="$LIBPREFIX/include"
#  configure search path
export CPPFLAGS="-I$LIBPREFIX/include"
export LDFLAGS="-L$LIBPREFIX/lib"
#  compiler arguments
export CFLAGS="-O3 -Wall"
export CXXFLAGS="$CFLAGS"
