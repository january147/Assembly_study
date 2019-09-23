#include<stdio.h>

float float_mov(float v1, float v2, float v3, float *dst) {
    *dst = v1;
    return v1;
}

int int_mov(int v1, int *dst) {
    *dst = v1;
    return v1;
}

long pushtest();
long poptest();

int main(){
    long value = 555;
    //value = poptest();
    printf("%02lx\n", value);
    return 0;
}
