
#include <kifx/SerialDevice.hpp>

#include <rpi/Uart0SerialDevice.hpp>

void wait(int cycles) {
  for (int i = 0; i < cycles; i++);
}

extern "C" void kernel_main() {
  rpi::Uart0SerialDevice serialDevice;

  serialDevice.init();
  kifx::writeString(serialDevice, "Serial output is up and running.\n");

  // Never exit.
  while (1);
}
