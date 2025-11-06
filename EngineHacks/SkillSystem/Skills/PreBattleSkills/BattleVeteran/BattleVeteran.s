.thumb
.equ BattleVeteranID, SkillTester+4

push {r4-r7, lr}
mov r4, r0 @atkr
mov r5, r1 @dfdr

@has Battle Veteran/Unyielding
ldr r0, SkillTester
mov lr, r0
mov r0, r4 @attacker data
ldr r1, BattleVeteranID
.short 0xf800
cmp r0, #0
beq End

@add SPEED damage
    mov   r0,r4     @Moving r0 to attacker data
    add   r0,#0x5c  @Loading defense into r0      
    ldrh  r2,[r0]   @Loading defense into r2
	lsr   r2,r2,#1   @Halving defense
    mov   r1,r4     @Moving r1 to attacker data
    add   r1,#0x5a  @Loading damage into r1
    ldrh  r3,[r1]   @Loading damage into r3
    add   r3,r3,r2  @Adding half of defense to damage
    strh  r3,[r1]   @Storing the new damage value into r1

End:
pop {r4-r7, r15}
.align
.ltorg
SkillTester:
@Poin SkillTester
@WORD BattleVeteranID
