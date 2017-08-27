#ifndef _rpi_Uart0SerialDevice_hpp
#define _rpi_Uart0SerialDevice_hpp

#include <kifx/SerialDevice.hpp>

namespace rpi {

class Uart0SerialDevice : public kifx::SerialDevice {
public:

  Uart0SerialDevice();
  virtual ~Uart0SerialDevice();

  virtual void init() override;
  virtual void writeCharacter(char c) override;

};

} // namepsace rpi

#endif // _rpi_Uart0SerialDevice_hpp

