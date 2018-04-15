cmake_minimum_required( VERSION "3.0" )

project( arm-littleos C CXX ASM )

set( PROJECT_TOP_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include )

set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11" CACHE STRING "C++ Flags" )

include_directories( ${PROJECT_TOP_INCLUDE_DIR} )

add_subdirectory( src )

