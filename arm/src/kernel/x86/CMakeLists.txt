cmake_minimum_required( VERSION 3.8 )

project( x86_64_Start C ASM_NASM )

set( CMAKE_EXE_LINKER_FLAGS "-T ${CMAKE_CURRENT_SOURCE_DIR}/link.ld -felf_i386" )

set( CMAKE_C_LINK_EXECUTABLE "ld <LINK_FLAGS> <OBJECTS>  -o <TARGET> <LINK_LIBRARIES>" )
add_executable( kernel.elf start.asm dummy.c )

set( ISO_STAGE_PATH "${CMAKE_CURRENT_BINARY_DIR}/iso/boot" )
add_custom_command(
  OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/os.iso"
  COMMAND cmake -E make_directory "${ISO_STAGE_PATH}/grub"
  COMMAND cmake -E copy "${CMAKE_CURRENT_SOURCE_DIR}/stage2_eltorito" "${ISO_STAGE_PATH}/grub"
  COMMAND cmake -E copy "${CMAKE_CURRENT_SOURCE_DIR}/menu.lst" "${ISO_STAGE_PATH}/grub"
  COMMAND cmake -E copy "kernel.elf" "${ISO_STAGE_PATH}"
  COMMAND genisoimage -R
    -b boot/grub/stage2_eltorito
    -no-emul-boot
    -boot-load-size 4
    -A os
    -input-charset utf8
    -quiet
    -boot-info-table
    -o os.iso
    iso
  WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
  DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/kernel.elf"
  COMMENT "Creating bootable ISO image"
)

add_custom_target( CreateIsoImage DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/os.iso" )
