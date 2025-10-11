#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
  printf(2, "Killing random process...\n");
  int randomPid = killrandom();
  printf(2, "Killed random process with id %d\n", randomPid);
  exit();
}
