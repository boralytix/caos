#include <stdio.h>
#include <stdlib.h>

extern int A, B, R;
extern void process(void);

int main(int argc, char** argv) {
    if (argc != 3) {
        fprintf(stderr, "usage: %s <A> <B>\n", argv[0]);
        return 2;
    }
    A = (int)strtol(argv[1], NULL, 10);
    B = (int)strtol(argv[2], NULL, 10);
    process();
    printf("%d\n", R);
    return 0;
}
