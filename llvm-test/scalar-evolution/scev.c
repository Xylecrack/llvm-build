#include <stdio.h>

int main(){
    int a[100];
    for (int i = 0; i < 100; i++)
    {
        a[i]=(i+1)*(i+1)-i*i-2*i;
    }
    for (int i = 0; i < 100; i++)
    {
        printf("%d",a[i]);
    }
    return 0;
}