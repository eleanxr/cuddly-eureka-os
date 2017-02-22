project( rpi )

set( ${PROJECT_NAME}_SOURCES
  Uart0SerialDevice.cpp
)

set( ${PROJECT_NAME}_HEADERS
  ${PROJECT_TOP_INCLUDE_DIR}/rpi/Uart0SerialDevice.hpp
)

add_library( ${PROJECT_NAME} STATIC
  ${${PROJECT_NAME}_SOURCES}
  ${${PROJECT_NAME}_HEADERS}
)

target_link_libraries( ${PROJECT_NAME}
  kifx
)
