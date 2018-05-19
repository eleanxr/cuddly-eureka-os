set( CMAKE_SYSTEM_NAME Generic )
set( CMAKE_SYSTEM_PROCESSOR i386 )

set( CMAKE_C_COMPILER gcc )
set( CMAKE_CXX_COMPILER g++ )
set( CMAKE_ASM_NASM_COMPILER nasm )

set( CMAKE_ASM_NASM_FLAGS "-felf32" CACHE STRING "Required NASM flags." )
set( CMAKE_C_FLAGS "-m32 -nostdlib -nostdinc -fno-builtin -fno-stack-protector -nostartfiles -nodefaultlibs" CACHE STRING "C Flags" )
set( CMAKE_EXE_LINKER_FLAGS "-felf_i386" )
