
project( kernel )

set( ${PROJECT_NAME}_HEADERS
)

set( ${PROJECT_NAME}_SOURCES
  # This must come first.
  # FIXME: deal with this in a linker script.
  start.s
  kernel_main.cpp
)

add_executable( "${PROJECT_NAME}"
  ${${PROJECT_NAME}_SOURCES}
  ${${PROJECT_NAME}_HEADERS}
)

target_link_libraries( ${PROJECT_NAME}
  kifx
  rpi
)

add_custom_command(
  TARGET "${PROJECT_NAME}"
  COMMAND ${CMAKE_OBJCOPY} ./${PROJECT_NAME}${EXECUTABLE_SUFFIX} -O binary kernel.img
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "Convert ELF output to binary image"
)
