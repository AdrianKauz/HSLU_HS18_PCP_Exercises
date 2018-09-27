/*
 * Header declaration for PCP iteration implementation
 *
 * Author: adrian.kauz@stud.hslu.ch
 */

/**
 * Printing numbers from 0 to newNumber
 *
 * @author  Adrian Kauz
 * @param  newNumber as initial number
 */
void printNumbersGoto(int const newNumber);


/**
 * Printing numbers from 0 to newNumber
 *
 * @author  Adrian Kauz
 * @param  newNumber as initial number
 */
void printNumbersFor(int const newNumber);


/**
 * Printing numbers from 0 to newNumber
 *
 * @author  Adrian Kauz
 * @param  newNumber as initial number
 */
void printNumbersRecursiveFunction(int const newNumber);


/**
 * Helper-Function for printNumbersRecursiveFunction()
 *
 * @author  Adrian Kauz
 * @param  currCounter as current counter-variable for recursive
 * @param  newNumber as initial number
 */
void printNumbers(int currCounter, int const newNumber);