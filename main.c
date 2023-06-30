/*
This .c program is wrapper for quicksort algoritm implemented in assmenbly x86 AT&T languagge
To run this program can be used:
    gcc main.c sort.s -o prog
    ./prog
commands
*/

#include <stdio.h>
#include <stdlib.h>

// Declaration exter quicksort funclion 
extern void quicksort(long* array, long left, long right);

long main(void){
    // Number of elements to sort
    long num_elements;
    printf("Number of elements: ");
    scanf("%ld", &num_elements);

    // Allocation of memory for array
    long* array = malloc(num_elements * sizeof(long));
    if (!array) {
        fprintf(stderr, "Failed to allocate memory.\n");
        return 1;
    }

    // Loading numbers
    for (int i = 0; i < num_elements; ++i) {
        printf("Element number %d: ", i+1);
        scanf("%ld", &array[i]);
    }

    // Calling extern quicksort
    quicksort(array,0, num_elements - 1);

    // Printing sorted array
    printf("\nElements in sorted order:\n%ld", array[0]);
    for (int i = 1; i < num_elements; i++) {
        printf(" %ld", array[i]);
    }
    printf("\n");

    // Deallocation of used memory
    free(array);

    return 0;
}