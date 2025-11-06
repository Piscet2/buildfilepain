.thumb
.equ VanityID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Vanity/Glacial
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, VanityID
.short 0xf800
cmp r0, #0
beq End

@add RES damage

    mov   r0,r4     @Moving r0 to attacker data
    add   r0,#0x18  @Loading resistance into r0      
    ldrh  r2,[r0]   @Loading resistance into r2
	lsr   r2,r2,#1  @Halving resistance
    mov   r1,r4     @Moving r1 to attacker data
    add   r1,#0x5a  @Loading damage into r1
    ldrh  r3,[r1]   @Loading damage into r3
    add   r3,r3,r2  @Adding half of resistance to damage
    strh  r3,[r1]   @Storing the new damage value into r1
	@mov   r0,r4     @resetting r0
	@add   r0,#0x5E  @Loading AS into r0
	@ldrh  r3,[r0]   @Loading AS into r3
	@sub   r3,r3,r2  @Subtract resistance from attack speed
	@strh  r3,[r0]   @Storing the new AS value into r0

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD VanityID
