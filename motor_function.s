.global motor_function



motor_function:				#initiation
	addi sp, sp, -4
	stw ra, 0(sp)
	
	.equ ADDR_JP1, 0xFF200060     # Address GPIO JP1

	movia  r8, ADDR_JP1     


	movia  r9, 0x07f557ff         # set direction for motors to all output 

	stwio  r9, 4(r8)

	beq r4, r0, forward
	movi r11, 1
	beq r4, r11, left
	movi r11, 2
	beq r4, r11, backward
	movi r11, 3
	beq r4, r11, right


forward:
	movia r11, 0xfffffffA		#set motor directions forward
	stwio r11, 0(r8)
	movia r4, 0x50
	call delay					#wait a little
	br begin_movement
	
backward:
	movia r11, 0xfffffff0 		#set motor directions backward
	stwio r11, 0(r8)
	movia r4, 0x50
	call delay					#wait a little
	br begin_movement
	
left:
	movia r11, 0xfffffff2 		#set motor directions left
	stwio r11, 0(r8)
	movia r4, 0x50
	call delay					#wait a little
	br begin_movement
	
right:
	movia r11, 0xfffffff8 		#set motor directions right
	stwio r11, 0(r8)
	movia r4, 0x50
	call delay					#wait a little
	
begin_movement:					#turn motors on
	#stwio r11, 0(r8)	#call delay					#wait a little
	movia r4, 0xF4
	movia r11, 0xffffffff		#turn motors off
	stwio r11,0(r8)
	call delay					#wait a little
	
	ldw ra, 0(sp)
	addi sp, sp, 4
	
ret
