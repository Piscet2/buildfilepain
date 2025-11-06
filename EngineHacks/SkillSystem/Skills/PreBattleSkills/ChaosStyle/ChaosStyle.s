.equ ChaosStyleID, SkillTester+4
.equ gBattleData, 0x203a4d4
.thumb

push {r4-r7,lr}
@goes in the battle loop.
@r0 is the attacker
@r1 is the defender
mov r4, r0
mov r5, r1

@make sure we're in combat (or battle forecast)
ldrb r3, =gBattleData
ldrb r3, [r3]
cmp r3, #4
beq End

@check for skill
ldr r0, SkillTester
mov lr, r0
mov r0, r4
ldr r1, ChaosStyleID
.short 0xf800
cmp r0, #0
beq End

@Check for own weapon
mov r0, r4
mov r1, #0x4c    @Move to the attackers's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
bne MagicalAttacker

mov r0, r5
mov r1, #0x4c    @Move to the defender's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
bne Effect @Magic bit set -> go to effect

b End	@Neither magical -> end

MagicalAttacker:
mov r0,r5
mov r1, #0x4c    @Move to the defender's weapon ability
ldr r1, [r0,r1]
mov r2, #0x42
tst r1, r2
bne End @do nothing if magic bit set

Effect:
mov r0, r4
add r0,#0x5E	@attacker AS
mov r1, r4
add r1,#0x5a    @attacker damage
ldrh r3,[r0]    @load AS into r3
add r3,#5		@add 3 AS
ldrh r2,[r1]    @load damage into r2
add  r2,#5      @add 5 damage
strh r3,[r0]

End:
pop {r4-r7}
pop {r0}
bx r0

.ltorg
.align

SkillTester:
@POIN SkillTester
@WORD ChaosStyleID
