#include "types.h"
#include "random.h"

static unsigned long int next = 1;

int rand(void)  // RAND_MAX assumed to be 32767
{
    next = next * 1103515245 + 12345;
    return (unsigned int) (next / 65536) % 32768;
}

int rand_between(int a, int b)
{
    return (rand() * b) / 32768 + a;
}

void srand(unsigned int seed)
{
    if(next != 1) return;
    next = seed;
}

unsigned int getseed(void){
    return next;
}
