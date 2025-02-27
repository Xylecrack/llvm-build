#include <stdio.h>

int main() {
    int n = 19; // You can change this number
    while (n > 1) {
        if (n % 2 == 0) {
            n /= 2; // If even, divide by 2
        } else {
            n = 3 * n + 1; // If odd, apply Collatz function
        }
    }
    printf("%d\n", n); // Will always print 1
    return 0;
}
