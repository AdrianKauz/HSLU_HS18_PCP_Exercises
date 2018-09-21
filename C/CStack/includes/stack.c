/*
 * Stack implementation based on a array.
 *
 * Author:      Ruedi Arnold @ Hochschule Luzern - Informatik
 * Modified by: Adrian Kauz
 */

#include <stdio.h>
#include <stdlib.h>
#include "stack.h"

/*
================
init()
================
*/
stack init() {
    stack s;
    s.index = STACK_EMPTY_INDEX;
    return s;
}


/*
================
push()
================
*/
stack push(element e, stack s)
{
    if (s.index + 1 < STACK_SIZE) {
        // there is space for one more element
        s.index++;
        s.stackArray[s.index] = e;
    } else {
        printf("ERROR - push: stack full! Cannot add %i\n", e);
    }
    return s;
}


/*
================
top()
================
*/
element top(stack s) {
    if (s.index > STACK_EMPTY_INDEX) {
        return s.stackArray[s.index];
    } else {
        printf("ERROR - top: stack empty!\n");
        return STACK_DUMMY_ELEMENT;
    }
}


/*
================
pop()
================
*/
stack pop(stack s) {
    if (s.index > STACK_EMPTY_INDEX) {
        s.index--;
    }
    return s;
}


/*
================
print()
================
*/
void print(stack s) {
    if (s.index > STACK_EMPTY_INDEX) {
        printf("print - Stack contains: ");
        int i;
        for (i = 0; i <= s.index; i++) {
            printf("%i, ", s.stackArray[i]);
        }
        printf("top element = %i\n", s.stackArray[s.index]);
    } else {
        printf("print - Stack is empty\n");
    }
}


/*
================
isEmpty()
================
*/
int isEmpty(stack s) {
    return (s.index > STACK_EMPTY_INDEX) ? 0 : 1;
}


/*
================
size()
================
*/
int size(stack s) {
    return (s.index > STACK_EMPTY_INDEX) ? (s.index + 1) : 0 ;
}