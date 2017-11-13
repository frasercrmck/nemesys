cmake_minimum_required( VERSION 3.5 )

set( RTL_SRC_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src/rtl" )

add_subdirectory(test/rtl)

set( LLVM_TARGETS_TO_BUILD "Nemesys" )

add_subdirectory(src/llvm)
