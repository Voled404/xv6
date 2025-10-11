#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
  int favnum = getfavnum();
  printf(2, "%d\n", favnum);
  exit();
}
