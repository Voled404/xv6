#include "types.h"
#include "user.h"
#include "pstat.h"
#include "random.h"
#define MIN 10
#define MAX 20
#define TRIES 10000000

void main(int argc, char *argv[]) {
    int n = MAX - MIN;
    int randTable[n];
    // Initialize garbage values
    for(int i = 0; i <= n; i++){
        randTable[i] = 0;
    }

    printf(1, "Stress testing random (MIN=%d, MAX=%d, TRIES=%d, AVG=%d)...\n", MIN, MAX, TRIES, (TRIES / (n + 1)));
    for(int i = 0; i < TRIES; i++){
        randTable[random(MIN, MAX) - MIN] += 1;
    }
    int total = 0;
    for(int i = 0; i <= n; i++){
        total += randTable[i];
        printf(1, "%d: %d\n", (i + MIN), randTable[i]);
    }
    printf(1, "Total numbers in range: %d", total);
    if(total != TRIES){
        printf(1, " (some numbers are out of bounds, expected was %d)\n", TRIES);
    }else{
        printf(1, " (no numbers out of bounds)\n");
    }

    exit();
}
