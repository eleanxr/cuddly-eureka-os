
#include <kifx/SerialDevice.hpp>

#include <rpi/Uart0SerialDevice.hpp>

#include <iostream>

#include <cstdio>

void wait(int cycles) {
  for (int i = 0; i < cycles; i++);
}

extern "C" {
  extern kifx::SerialDevice * sSerialDevice;
}

extern "C" void kernel_main() {
  rpi::Uart0SerialDevice serialDevice;
  sSerialDevice = &serialDevice;

  sSerialDevice->init();
  kifx::writeString(*sSerialDevice, "Direct serial output.\n");
  printf("C stdio output.\n");

  std::ios_base::Init init;
  std::cout << "std::cout output." << std::endl;
  // Never exit.
  while (1);
}
