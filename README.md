# Quicksort Program

This program is a wrapper for the quicksort algorithm implemented in assembly x86 AT&T language. It sorts an array of numbers in ascending order.

## Usage

To run this program, follow these steps:

1. Compile the program using the following command:

    ```shell
    gcc main.c sort.s -o prog

2. Execute the program:

    ```shell
    ./prog

3. The program will prompt you to enter the number of elements you want to sort.

4. Enter the elements one by one when prompted.

5. The program will sort the array using the quicksort algorithm and display the sorted elements.

## Example
    
    Number of elements: 3
    Element number 1: 5
    Element number 2: 8
    Element number 3: 0 

    Elements in sorted order: 0 5 8


## Program Files

- `main.c`: This file contains the main C program that acts as a wrapper for the quicksort algorithm implemented in assembly.
- `sort.s`: This file contains the assembly implementation of the quicksort algorithm.