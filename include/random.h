static unsigned long int next = 1;  // NB: "unsigned long int" is assumed to be 32 bits wide

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

int getseed(void){
    return next;
}
