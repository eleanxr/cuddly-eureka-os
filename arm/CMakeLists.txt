cmake_minimum_required( VERSION "3.0" )

project( kernel C ASM )

include_directories( ${CMAKE_CURRENT_SOURCE_DIR} )

set( ${PROJECT_NAME}_HEADERS
)

set( ${PROJECT_NAME}_SOURCES
  start.s
  print_uart.c
)

add_executable( "${PROJECT_NAME}"
  ${${PROJECT_NAME}_SOURCES}
  ${${PROJECT_NAME}_HEADERS}
)

add_custom_command(
  TARGET "${PROJECT_NAME}"
  COMMAND ${CMAKE_OBJCOPY} ./${PROJECT_NAME}${EXECUTABLE_SUFFIX} -O binary kernel.img
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Convert ELF output to binary image"
)
