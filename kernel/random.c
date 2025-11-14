#include "types.h"
#include "random.h"

static unsigned long next = 1;

int rand(void)
{
    next = next * 1103515245 + 12345;
    return (next >> 1) & 0x7fffffff;   // 31-bit result: 0 .. 2,147,483,647
}

void srand(unsigned int seed)
{
    next = seed;
}

unsigned int getseed(void)
{
    return next;
}

int rand_between(int a, int b)
{
    return a + (rand() % (b - a + 1));
}
