set( TOOLCHAIN_PREFIX "arm-none-eabi-" )

set( CMAKE_SYSTEM_NAME Generic )
set( CMAKE_SYSTEM_PROCESSOR BCM2836 )

# Set the try compile target type to static library to keep it from trying to
# link the compiler test program.
set( CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY )

set( CMAKE_C_COMPILER "${TOOLCHAIN_PREFIX}gcc" )
set( CMAKE_CXX_COMPILER "${TOOLCHAIN_PREFIX}g++" )
set( CMAKE_OBJCOPY "${TOOLCHAIN_PREFIX}objcopy" CACHE STRING "The objcopy executable" )

set( ARCHITECTURE armv6zk )

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=${ARCHITECTURE} -nostartfiles" )
set( CMAKE_ASM_FLAGS "${CMAKE_C_FLAGS}" )
set( CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS}" )

set( CMAKE_C_FLAGS "${CMAKE_C_FLAGS}" CACHE STRING "C Compiler Flags" )
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}" CACHE STRING "C++ Compiler Flags" )
set( CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS}" CACHE STRING "Assembler flags" )
set( CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS}" CACHE STRING "Linker Flags" )
