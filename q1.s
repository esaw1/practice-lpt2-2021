/*
int func(int i, int j, int k, int *A) {
    if( i < j ) {
        A[0] = 1;
    }
    if( i == k ) {
        A[1] = 2;
        if( A[2] > j ) {
            A[3] = 4;
        }
    }
    return i+j;
}
*/

.global _start
_start:
    MOV R0, #1 // i=1
    MOV R1, #2 // j=2
    MOV R2, #1 // k=1
    LDR R3, =data // set base of A = first address of array “data”
BL func
END: B END // infinite loop; R0 should contain return value of func
.global func
func:
    CMP R0, R1
    BGE ge_ij
    MOV R4, #1
    STR R4, [R3, #0]

    ge_ij:
    CMP R0, R2
    BNE end_func
    MOV R4, #2
    STR R4, [R3, #4]
    LDR R4, [R3, #8]

    CMP R4, R1
    BLE end_func
    MOV R4, #4
    STR R4, [R3, #12]

    end_func:
    ADD R4, R0, R1
    MOV R0, R4
    MOV PC, LR
data:
    .word 0
    .word 0
    .word 3
    .word 0