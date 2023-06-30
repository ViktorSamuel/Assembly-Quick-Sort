/* Function to swap values between two memory locations */
swap_values:
        pushq   %rbp              /* Save previous base pointer */
        movq    %rsp, %rbp        /* Set current base pointer to current stack pointer */

        movq    %rdi, -24(%rbp)   /* Store the first value at -24(%rbp) */
        movq    %rsi, -32(%rbp)   /* Store the second value at -32(%rbp) */

        movq    -24(%rbp), %rax   /* Move the first value to %rax */
        movq    (%rax), %rax      /* Dereference the first value and store it in %rax */
        movq    %rax, -8(%rbp)    /* Store the dereferenced value at -8(%rbp) */

        movq    -32(%rbp), %rax   /* Move the second value to %rax */
        movq    (%rax), %rdx      /* Dereference the second value and store it in %rdx */

        movq    -24(%rbp), %rax   /* Move the first value to %rax */
        movq    %rdx, (%rax)      /* Store the dereferenced value in the first location */

        movq    -8(%rbp), %rdx    /* Move the stored dereferenced value to %rdx */

        movq    -32(%rbp), %rax   /* Move the second value to %rax */
        movq    %rdx, (%rax)      /* Store the stored dereferenced value in the second location */

        popq    %rbp              /* Restore previous base pointer */
        ret                       /* Return */

/* Function to partition the array around a pivot value */
partition_array:
        pushq   %rbp              /* Save previous base pointer */
        movq    %rsp, %rbp        /* Set current base pointer to current stack pointer */

        subq    $56, %rsp         /* Allocate space on the stack for local variables */

        movq    %rdi, -40(%rbp)   /* Store the array start address at -40(%rbp) */
        movq    %rsi, -48(%rbp)   /* Store the array end address at -48(%rbp) */
        movq    %rdx, -56(%rbp)   /* Store the pivot index at -56(%rbp) */

        movq    -48(%rbp), %rax   /* Move the array end address to %rax */
        leaq    0(,%rax,8), %rdx  /* Calculate the pivot element index */

        movq    -40(%rbp), %rax   /* Move the array start address to %rax */
        addq    %rdx, %rax        /* Add the pivot index to the start address */

        movq    (%rax), %rax      /* Dereference the pivot element and store it in %rax */
        movq    %rax, -24(%rbp)   /* Store the pivot value at -24(%rbp) */

        movq    -48(%rbp), %rax   /* Move the array end address to %rax */
        movq    %rax, -8(%rbp)    /* Store the array end address at -8(%rbp) */

        movq    -48(%rbp), %rax   /* Move the array end address to %rax */
        addq    $1, %rax          /* Increment the array end address by 1 */
        movq    %rax, -16(%rbp)   /* Store the incremented array end address at -16(%rbp) */

        jmp     sort_array        /* Jump to the sort label */

pivot:
        movq    -16(%rbp), %rax   /* Move the pivot index to %rax */
        leaq    0(,%rax,8), %rdx  /* Calculate the pivot element index */

        movq    -40(%rbp), %rax   /* Move the array start address to %rax */
        addq    %rdx, %rax        /* Add the pivot index to the start address */

        movq    (%rax), %rax      /* Dereference the pivot element and store it in %rax */
        cmpq    %rax, -24(%rbp)   /* Compare the pivot value with the value at -24(%rbp) */
        jle     increment         /* Jump to increment if the pivot value is less than or equal */

        addq    $1, -8(%rbp)      /* Increment the pivot index */

        movq    -8(%rbp), %rax    /* Move the pivot index to %rax */
        leaq    0(,%rax,8), %rdx  /* Calculate the index of the element to be swapped */

        movq    -40(%rbp), %rax   /* Move the array start address to %rax */
        addq    %rax, %rdx        /* Add the calculated index to the start address */

        movq    -16(%rbp), %rax   /* Move the pivot index to %rax */
        leaq    0(,%rax,8), %rcx  /* Calculate the index of the pivot element */

        movq    -40(%rbp), %rax   /* Move the array start address to %rax */
        addq    %rcx, %rax        /* Add the calculated index to the start address */

        movq    %rdx, %rsi        /* Move the swap index to %rsi */
        movq    %rax, %rdi        /* Move the pivot index to %rdi */

        call    swap_values       /* Call the swap_values subroutine to swap the elements */

increment:
        addq    $1, -16(%rbp)     /* Increment the pivot index */

sort_array:
        movq    -16(%rbp), %rax   /* Move the pivot index to %rax */
        cmpq    -56(%rbp), %rax   /* Compare the pivot index with the array end index */
        jle     pivot             /* Jump to pivot if the pivot index is less than or equal */

        movq    -8(%rbp), %rax    /* Move the pivot index to %rax */
        leaq    0(,%rax,8), %rdx  /* Calculate the index of the element to be swapped */

        movq    -40(%rbp), %rax   /* Move the array start address to %rax */
        addq    %rax, %rdx        /* Add the calculated index to the start address */

        movq    -48(%rbp), %rax   /* Move the array end address to %rax */
        leaq    0(,%rax,8), %rcx  /* Calculate the index of the pivot element */

        movq    -40(%rbp), %rax   /* Move the array start address to %rax */
        addq    %rcx, %rax        /* Add the calculated index to the start address */

        movq    %rdx, %rsi        /* Move the swap index to %rsi */
        movq    %rax, %rdi        /* Move the pivot index to %rdi */

        call    swap_values       /* Call the swap_values subroutine to swap the elements */

        movq    -8(%rbp), %rax    /* Move the pivot index to %rax */
        leave                    /* Restore the previous base pointer and deallocate local variables */
        ret                      /* Return from the function */

.globl  quicksort
quicksort:
    pushq   %rbp              /* Save previous base pointer */
    movq    %rsp, %rbp        /* Set current base pointer to current stack pointer */
    
    subq    $48, %rsp         /* Allocate space on the stack for local variables */

    movq    %rdi, -24(%rbp)   /* Store the array start address at -24(%rbp) */
    movq    %rsi, -32(%rbp)   /* Store the array end address at -32(%rbp) */
    movq    %rdx, -40(%rbp)   /* Store the pivot index at -40(%rbp) */

    movq    -32(%rbp), %rax   /* Move the array end address to %rax */
    cmpq    -40(%rbp), %rax   /* Compare the array end index with the pivot index */
    jge     end               /* Jump to end if the array end index is greater than or equal */

    movq    -40(%rbp), %rdx   /* Move the pivot index to %rdx */
    movq    -32(%rbp), %rcx   /* Move the array end address to %rcx */
    movq    -24(%rbp), %rax   /* Move the array start address to %rax */
    movq    %rcx, %rsi        /* Move the array end address to %rsi */
    movq    %rax, %rdi        /* Move the array start address to %rdi */
    call    partition_array   /* Call the partition_array subroutine to partition the array */
    movq    %rax, -8(%rbp)    /* Store the pivot index at -8(%rbp) */

    movq    -8(%rbp), %rax    /* Move the pivot index to %rax */
    leaq    -1(%rax), %rdx    /* Calculate the new array end index */
    movq    -32(%rbp), %rcx   /* Move the array end address to %rcx */
    movq    -24(%rbp), %rax   /* Move the array start address to %rax */
    movq    %rcx, %rsi        /* Move the array end address to %rsi */
    movq    %rax, %rdi        /* Move the array start address to %rdi */
    call    quicksort         /* Call quicksort recursively for the lower partition */

    movq    -8(%rbp), %rax    /* Move the pivot index to %rax */
    leaq    1(%rax), %rcx     /* Calculate the new array start index */
    movq    -40(%rbp), %rdx   /* Move the pivot index to %rdx */
    movq    -24(%rbp), %rax   /* Move the array start address to %rax */
    movq    %rcx, %rsi        /* Move the array start address to %rsi */
    movq    %rax, %rdi        /* Move the array end address to %rdi */
    call    quicksort         /* Call quicksort recursively for the upper partition */

end:
    leave                    /* Restore the previous base pointer and deallocate local variables */
    ret                      /* Return from the function */
