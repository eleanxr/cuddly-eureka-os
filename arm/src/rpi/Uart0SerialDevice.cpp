#include <rpi/Uart0SerialDevice.hpp>

#include <rpi/Peripheral.hpp>

/* Define the UART0 offsets here manually, as the structure has some alignment
 * issues that I need to solve. */
#define DR 0x0
#define CR 0x30
#define ICR 0x44
#define IBRD 0x24
#define FBRD 0x28
#define LCRH 0x2c
#define IMSC 0x38

namespace {

/* IRQ Enable 2 Address responsible for IRQ sources 63:32 */
volatile unsigned int * const IRQ_ENABLE_2 = (unsigned int *)RPI_PERIPHERAL(0x00B214);

/* UART0 (PL011) base address.  */
volatile unsigned int * const UART0_ADDRESS = (unsigned int *)RPI_PERIPHERAL(0x201000);

/* GPFSEL0 Register to enable GPIO14 as alternate function 0 */
/* According to the BC2835 peripherals, the PL011 UART0 interface is available
 * as alternate function 0 on GPIO pin 14 for transmission and 15 for
 * receiving. */
volatile unsigned int * const GPFSEL1 = (unsigned int *)RPI_PERIPHERAL(0x200004);
volatile unsigned int * const GPPUD = (unsigned int *)RPI_PERIPHERAL(0x200094);
volatile unsigned int * const GPPUDCLK0 = (unsigned int *)RPI_PERIPHERAL(0x200098);

/*
FIXME: Deal with the funky offset between RSRECR and FR. We probably need some
padding in this structure before it'd be usable.
typedef struct {
  uint32_t DR;
  uint32_t RSRECR;
  uint32_t FR;
  uint32_t ILPR;
  uint32_t IBRD;
  uint32_t FBRD;
  uint32_t LCRH;
  uint32_t CR;
  uint32_t IFLS;
  uint32_t IMSC;
  uint32_t RIS;
  uint32_t MIS;
  uint32_t ICR;
  uint32_t DMACR;
  uint32_t ITCR;
  uint32_t ITIP;
  uint32_t ITOP;
  uint32_t TDR;
} uart0_t;
*/

volatile unsigned int * get_uart0() {
  return reinterpret_cast<volatile unsigned int *>(UART0_ADDRESS);
}

} // namespace

namespace rpi {

Uart0SerialDevice::Uart0SerialDevice() {
}

Uart0SerialDevice::~Uart0SerialDevice() {
}

void Uart0SerialDevice::init() {
  int i;

  *GPFSEL1 = 1 << 14;

  *GPPUD = 0;
  for (i = 0; i < 150; i++);
  *GPPUDCLK0 = 1 << 14;
  for (i = 0; i < 150; i++);
  *GPPUDCLK0 = 0;

  /* The UART IRQ Source bit number (57-32) */
  const unsigned int uart_irq_source = 25;
  *IRQ_ENABLE_2 = 1 << uart_irq_source;

  /* Initialize the UART */
  unsigned int UART_TXE = 1 << 8;
  unsigned int UART_ENABLE = 1;
  volatile unsigned int * uart = get_uart0();
  *(uart+CR) = 0;
  *(uart+ICR)=0x7ff;
  *(uart+IBRD)=1;
  *(uart+FBRD)=40;
  
  *(uart+LCRH)=(1<<4)|(1<<5)|(1<<6);

  *(uart+IMSC) = (
    (1<<4) | (1<<4) | (1<<5) | (1<<6) |
    (1<<7) | (1<<8) | (1<<9) | (1<<10)
  );
  
  *(uart+CR)=UART_TXE | UART_ENABLE;
}

void Uart0SerialDevice::writeCharacter(char c) {
  *(get_uart0()+DR) = static_cast<unsigned int>(c);
}

} // namespace rpi

