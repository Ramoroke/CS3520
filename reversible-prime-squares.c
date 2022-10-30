//
//  main.c
//  CS3520_Assignment
//
//  Created by Tsele Ramoroke on 08/10/2022.
//

#include <stdio.h>
#include <math.h>

//Function declaration
int prime_number(int);
int square_number(int);
int reverse_number(int);
int palindrome_check(int, int);
int square_root(int);

int main() {
    // Declarations
    int n, c, a, result, square, reverse, palindrome, squareroot, secresult;
    
    // Number of reversible prime numbers needed e.g 10
    printf("Enter the number of reversible prime numbers needed: \n");
    scanf("%d", &n);
    
    // initialization
    a = 0;
    c = 2;
    while (a < n) {
        result = prime_number(c);
        if (result == 0) {
            c = c + 1;
        } else {
            square = square_number(c);
            reverse = reverse_number(square);
            palindrome = palindrome_check(square, reverse);
            
            if (palindrome == 0) {
                c = c + 1;
            } else {
                squareroot = square_root(reverse);
                secresult = prime_number(squareroot);
                if (secresult == 0) {
                    c = c + 1;
                } else {
                    printf("%d  %d,\t", square, reverse);
                    c = c + 1;
                    a = a + 1;
                }
            }
        }
    }
    
    return 0;
}

// Check if prime
int prime_number(int a){
    int c;
    for (c = 2; c <= a - 1; c++) {
        // if it is not prime
        if (a%c == 0)
            return 0;
    }
    // if it is prime
    if (c==a)
        return 1;
    return 1;
}

// Square the prime
int square_number(int a){
    int sqr = 0;

    sqr = a * a;
    return sqr;
}

// Reverse the Square
int reverse_number(int a) {
    int rev = 0;
    
    while (a != 0) {
        rev = rev *10;
        rev = rev + a % 10;
        a = a/10;
    }
    
    return rev;
}

// check reverse and square are palidromes
int palindrome_check(int a, int b){
    if (a == b) {
        //if it is a palindrome
        return 0;
    }
    // if it is not a palindrome
    return 1;
}

//Check the square root of reverse
int square_root(int a){
    int squareroot;
    squareroot = sqrt(a);
    return squareroot;
}
