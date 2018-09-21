/*
 * Header declaration for PCP stack implementation
 *
 * Author:      Ruedi Arnold @ Hochschule Luzern - Informatik
 * Modified by: Adrian Kauz
 */

#ifndef STACK_H
#define	STACK_H

#define STACK_SIZE 3
#define STACK_EMPTY_INDEX -1
#define STACK_DUMMY_ELEMENT -1234 // attention: arbitrary number used as dummy :-(

typedef int element;

typedef struct {
    element stackArray[STACK_SIZE];
    int index;
} stack;

/**
 * Returns new empty stack.
 *
 * @author  Ruedi Arnold
 * @return  stack
 */
stack init();


/**
 * Adds a new element onto the stack.
 *
 * @author  Ruedi Arnold
 * @param   e as Address-Item to clear
 * @param   s as current stack
 * @return  Current stack
 */
stack push(element e, stack s);


/**
 * Returns the latest element from the stack. Without decrementation!
 *
 * @author  Ruedi Arnold
 * @param   s as current stack
 * @return  element
 */
element top(stack s);


/**
 * Removes the lastest element from the stack.
 *
 * @author  Ruedi Arnold
 * @param   s as current stack
 * @return  Current stack
 */
stack pop(stack s);


/**
 * Prints content of stack.
 *
 * @author  Ruedi Arnold
 * @param   s as current stack
 */
void print(stack s);


/**
 * Returns 1 if stack is empty, otherwise 0.
 *
 * @author  Adrian Kauz
 * @param   s as current stack
 * @return  int
 */
int isEmpty(stack s);


/**
 * Returns size of stack.
 *
 * @author  Adrian Kauz
 * @param   s as current stack
 * @return
 */
int size(stack s);

#endif	/* STACK_H */