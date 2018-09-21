/*
 * The main function, testing our PCP stack implementation.
 *
 * Author:      Ruedi Arnold @ Hochschule Luzern - Informatik
 * Modified by: Adrian Kauz
 */

#include <stdio.h>
#include <stdlib.h>
#include "includes/stack.h"

/*
================
main()
================
*/
int main(int argc, char** argv) {
    stack myStack = init();

    /*
    print(myStack);
    top(myStack);
    myStack = push(42, myStack);
    myStack = push(77, myStack);
    myStack = push(1, myStack);
    print(myStack);
    myStack = push(33, myStack);
    myStack = pop(myStack);
    myStack = push(33, myStack);
    print(myStack);
    element e = top(myStack);
    printf("top element is %i\n", e);
    print(myStack);
    */

    printf("size(myStack) = %i\n", size(myStack));
    printf("isEmpty(myStack) = %i\n", isEmpty(myStack));
    print(myStack);
    top(myStack);
    myStack = push(42, myStack);
    myStack = push(77, myStack);
    myStack = push(1, myStack);
    printf("size(myStack) = %i\n", size(myStack));
    printf("isEmpty(myStack) = %i\n", isEmpty(myStack));
    print(myStack);

    return (EXIT_SUCCESS);
}