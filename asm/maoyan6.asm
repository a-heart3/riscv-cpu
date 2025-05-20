lw 0(r0), r1
lw 4(r0), r2
beq r1, r2, .test
add r3, r4, r5
add r6, r7, r8
sub r1, r2, r3
.test:
add r1, r2, r3
