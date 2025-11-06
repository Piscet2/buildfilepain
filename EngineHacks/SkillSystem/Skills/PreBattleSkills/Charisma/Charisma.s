.thumb
.equ CharismaID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Charisma
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, CharismaID
.short 0xf800
cmp r0, #0
beq End

@add SPEED damage
    mov   r0,r4     @Moving r0 to attacker data
    add   r0,#0x16  @Loading AS into r0      
    ldrh  r2,[r0]   @Loading AS into r2
	lsr   r2,r2,#1  @Halving AS
    mov   r1,r4     @Moving r1 to attacker data
    add   r1,#0x5C  @Loading damage(0x5a)/defense(0x5c) into r1
    ldrh  r3,[r1]   @Loading damage into r3
    add   r3,r3,r2  @Adding changed Attack Speed to damage
    strh  r3,[r1]   @Storing the new damage value into r1

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD CharismaID
