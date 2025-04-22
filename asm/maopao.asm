lw 5(r0), r1     // zhushi test
lw 6(r0), r2
lw 7(r0), r3
lw 8(r0), r4
lw 9(r0), r5
addi -1, r5, r6
.L1:
blt r6, r1, .L2
.end:
.L2:
sub r3, r3, r3
sub r4, r4, r4
sub r1, r5, r7
.L3:
bge r7, r2, .L6
lw 0(r2), r8
lw 1(r2), r9
blt r9, r8, .L5
.L4:
addi 1, r2, r2
jal r18, .L3
.L5:
addi 0, r8, r4
addi 0, r9, r8
addi 0, r4, r9
sw r8, 0(r2)
sw r9, 0(r2)
addi 1, r0, r3
jal r19, .L4
.L6:
beq r0, r3, .end
addi 1, r1, r1
jal r20, .L1
