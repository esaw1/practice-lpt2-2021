/*
int loopy(int n, int *A, int *B) {
    int L1norm=0;
    int i=0;
    while( i < n ) {
        int tmp = A[i];
        if( tmp < 0 ) {
            tmp = -tmp;
        }
        B[i] = tmp;
        L1norm = L1norm + tmp;
        i = i + 1;
    }
    return L1norm;
}
 */

.global _start
_start:
    MOV R0, #2 // n=2
    LDR R1, =input // base of A = first address of array “input”
    LDR R2, =output// base of B = first address of array “output”
BL loopy
END: B END // infinite loop; R0 should contain return value of loopy
.global loopy
loopy:
    MOV R3, #0 // L1norm=0
    MOV R4, #0 // i=0

    loop:
    CMP R4, R0
    BGE end_loopy

    LDR R5, [R1, R4, LSL #2] // tmp
    CMP R5, #0
    BGE tmp_ge_0
    MVN R5, R5
    ADD R5, R5, #1

    tmp_ge_0:
    STR R5, [R2, R4, LSL #2]
    ADD R3, R3, R5
    ADD R4, R4, #1

    B loop

    end_loopy:
    MOV R0, R3
    MOV PC, LR
input:
    .word -1
    .word 1
output:
    .word 0
    .word 0