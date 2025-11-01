#include <stdio.h>

extern double my_sin(double x);

int main(void) {
    double x;
    if (scanf("%lf", &x) != 1) {
        fprintf(stderr, "input error\n");
        return 1;
    }

    double y = my_sin(x);
    printf("%.10f\n", y);
    return 0;
}
