#include <sys/stat.h>

#include <cerrno>
#undef errorno
extern int errno;

// Required for c++ programs to link with the GNU linker.
extern "C" {

// _exit
void _exit() {
  while ( 1 );
}

// _sbrk
caddr_t _sbrk( int incr ) {
  extern char _end;
  static char * heapEnd = 0;
  char * previousHeapEnd;

  if ( heapEnd == 0 ) {
    heapEnd = &_end;
  }

  previousHeapEnd = heapEnd;

  // TODO: Handle stack collision.
  heapEnd += incr;
  return static_cast< caddr_t >( previousHeapEnd );
}

// _kill
int _kill( int pid, int sig ) {
  errno = EINVAL;
  return -1;
}

// _getpid
int _getpid() {
  return 1;
}

// _write
int _write(int file, char *ptr, int len) {
  int todo;

  for (todo = 0; todo < len; todo++) {
    // outbyte( *ptr++ );
  }
  return len;
}

// _close
int _close(int file) {
  return -1;
}

// _fstat
int _fstat(int file, struct stat *st) {
  st->st_mode = S_IFCHR;
  return 0;
}

// _isatty
int _isatty( int file ) {
  return 1;
}

// _lseek
int _lseek(int file, int ptr, int dir) {
  return 0;
}

// _read
int _read(int file, char *ptr, int len) {
  return 0;
}

} // extern "C"
