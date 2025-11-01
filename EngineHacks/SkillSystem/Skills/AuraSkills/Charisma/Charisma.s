.thumb
.equ CharismaID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@hp not at full
ldrb r0, [r4, #0x12] @max hp
ldrb r1, [r4, #0x13] @curr hp

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
    add   r0,#0x5E  @Loading AS into r0      
    ldrh  r2,[r0]   @Loading AS into r2
    mov   r1,r4     @Moving r1 to attacker data
    add   r1,#0x5a  @Loading damage into r1
    ldrh  r3,[r1]   @Loading damage into r3
    add   r3,r3,r2  @Adding Attack Speed to damage
    strh  r3,[r1]   @Storing the new damage value into r1, which is in the same spot as damage

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD CharismaID
