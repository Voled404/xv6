#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
  int time = atoi(argv[1]);
  if(argc < 3 || time <= 0){
    printf(2, "Usage: countdown seconds message...\n");
    exit();
  }

  while(time > 0){
    printf(2, "%d\n", time);
    time -= 1;
    sleep(100);
  }

  for(int i = 2; i < argc; i++){
    printf(2, "%s", argv[i]);
    if(i < argc - 1){
      printf(2, " ");
    }
  }
  printf(2, "\n");
  exit();
}
