#include <stdio.h>
#include "iteration.h"

/*
================
printNumbersGoto()
================
*/
void printNumbersGoto(int const newNumber) {
    int counter = 0;

    LOOP:
    if(counter <= newNumber) {
        printf("%i ", counter);
        counter++;

        goto LOOP;
    }
}

/*
================
printNumbersFor()
================
*/
void printNumbersFor(int const newNumber) {
    for(int x = 0; x <= newNumber; x++) {
        printf("%i ",x);
    }
}

/*
================
printNumbersRecursiveFunction()
================
*/
void printNumbersRecursiveFunction(int const newNumber) {
    int counter = 0;
    printNumbers(counter, newNumber);
}

/*
================
printNumbers()
================
*/
void printNumbers(int currCounter, int const number) {
    if(currCounter <= number) {
        printf("%i ", currCounter);
        printNumbers(++currCounter, number);
    }
}