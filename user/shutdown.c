#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
  printf(2, "Shutting down emulator...\n");
  halt();
  exit(); //not reached
}
