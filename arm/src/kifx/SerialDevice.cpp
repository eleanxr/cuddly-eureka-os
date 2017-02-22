#include <kifx/SerialDevice.hpp>

namespace kifx {

SerialDevice::SerialDevice() {
}

SerialDevice::~SerialDevice() {
}

void writeString(SerialDevice& device, const char * s) {
  while (*s != '\0') {
    device.writeCharacter(*s++);
  }
}

} // namespace kifx

