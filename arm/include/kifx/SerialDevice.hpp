#ifndef _kifx_SerialDevice_hpp
#define _kifx_SerialDevice_hpp

#include <cstddef>

namespace kifx {

class SerialDevice {
public:
  virtual ~SerialDevice();

  virtual void init() = 0;
  virtual void writeCharacter(char c) = 0;

protected:
  SerialDevice();
};

void writeString(SerialDevice& device, const char * s);

} // namespace kifx

#endif // _kifx_SerialDevice_hpp

