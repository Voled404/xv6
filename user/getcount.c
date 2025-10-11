#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
  int syscall = atoi(argv[1]);
  if(argc < 2 || syscall == 0){
    printf(2, "Usage: getcount syscall\n");
    exit();
  }
  printf(2, "System call count: %d\n", getcount(syscall));
  exit();
}
