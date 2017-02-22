project( kifx )

set( ${PROJECT_NAME}_SOURCES
  SerialDevice.cpp
)

set( ${PROJECT_NAME}_HEADERS
  ${PROJECT_TOP_INCLUDE_DIR}/kifx/SerialDevice.hpp
)

add_library( ${PROJECT_NAME} STATIC
  ${${PROJECT_NAME}_SOURCES}
  ${${PROJECT_NAME}_HEADERS}
)
