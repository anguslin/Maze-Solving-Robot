.equ TIMER2, 0xFF202020

.global full_right_movement



full_right_movement:				#initiation
	addi sp, sp, -4
	stw ra, 0(sp)
	
	movia r16, TIMER2                   			# r16 contains the base address for the timer
    
    #movi r17, %lo(500000000) 
    #stwio r17, 8(r16)                          
    #movi r17, %hi(500000000)
    #stwio r17, 12(r16)
	
	movi r17, 0x3000
	sthio r17, 8(r16)
	srli r17, r17, 4
	stwio r17, 12(r16)
	
	stwio r0, 0(r16)
    movui r17, 4
    stwio r17, 4(r16)                          # Start the timer without continuing or interrupts 

right:
	movi r4, 3
	call motor_function
	ldwio r17, 0(r16)
    andi r17,r17, 0x1
    beq r17, r0, right						#check if time ran out
	
	movia r4, 0x500
	call delay
	
read_sensor_data:
	call get_sensor_state
	
epilogue:	
	ldw ra, 0(sp)
	addi sp, sp, 4
	
ret
