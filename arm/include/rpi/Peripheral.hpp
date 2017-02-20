
/*
 * On RPI, the peripheral base address is  2000 0000
 * On RPI2, the peripheral base address is 3f00 0000
 */
#ifdef RPI
  #define RPI_PERIPHERAL_BASE 0x20000000
#endif

#ifdef RPI_TWO
  #define RPI_PERIPHERAL_BASE 0x3f000000
#endif

#define RPI_PERIPHERAL(x) (RPI_PERIPHERAL_BASE + x)

