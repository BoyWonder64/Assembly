# name: Maitland
# date: 6/13
# description: given a radius, approximate the area of a circle

# data
.data

prompt: .asciiz "\nEnter a radius or 0 to quit: " # prompt
result: .asciiz "Approximate area: " # result
close: .asciiz "\nBye" #close
# Registers
# radius = $t0
# area = $t1
#




# text
.text

# pesudocode
#   while radius !=0 {
#	print (prompt)
#	readint
# 	calculate area
#	print(result)
#	print(area)
#	} //end while
# graceful close
# clean exit



# add the loop
loop:
	# print(prompt)
	li $v0, 4     # print string
	la $a0, prompt
	syscall
	# read(int)
	li $v0, 5	    # read int and save into $v0
	syscall
	move $t0, $v0  # save into $t0
	
	# if(radius == 0) break out of loop
	beqz $t0, endloop
	
	# calculate area    area = PI * radius squared
	# area = PI * radius * radius 
	li $t1, 3 #	approx of pi
	mul $t1, $t1, $t0  # $t1 = 3 * radius
	mul $t1, $t1, $t0  # $t1 = $t1 * radius
	
	# print(result)
	li $v0, 4     # print string
	la $a0, result
	syscall
	
	# print(area)
	li $v0, 1 	    # print int
	move $a0, $t1
	syscall

	j loop
endloop:

	# close
	li $v0, 4
	la $a0, close
	syscall
	
	# clean exit
	li $v0, 10
	syscall