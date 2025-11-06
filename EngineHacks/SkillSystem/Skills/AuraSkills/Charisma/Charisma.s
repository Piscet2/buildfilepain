.equ CharismaID, AuraSkillCheck+4
.thumb
push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

CheckSkill:
@now check for the skill
ldr r0, AuraSkillCheck
mov lr, r0
mov r0, r4 @attacker
ldr r1, CharismaID
mov r2, #0 @can_trade
mov r3, #3 @range
.short 0xf800
cmp r0, #0
beq End

@add Increase attack speed by 25%
    mov   r0,r4     @Moving r0 to attacker data
    add   r0,#0x5E  @Loading AS into r0      
    ldrh  r2,[r0]   @Loading AS into r2
    add   r3,r2   @Loading bonus AS into r3
	lsr   r3,r3,#2  @Dividing bonus AS by 4
	add   r2,r2,r3  @Adding bonus AS
	strh  r2,[r0]   @Storing boosted AS

End:
pop {r4-r7}
pop {r0}
bx r0
.align
.ltorg
AuraSkillCheck:
@Poin SkillTester
@WORD CharismaID
