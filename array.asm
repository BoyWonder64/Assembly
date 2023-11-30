#name: Maitland
# Date: 5/23
# Description: Add elements in an array, store the results in memory (label)
#              and display the results


# Data segment labels
.data
display: .asciiz "The result is: "
result: .word 0 # momeory location initialized to 4-bytes of zero
nums: .word -7, 20, -5

#When using an array, to get the index you count by 4 bytes so
# if you want the index of 2 you would as for 8 bytes IE 0,4,8 -> 0,1,2



#Text segment- code goes here
.text

# load an array into a register
	la $t0, nums
	
# put each value in a different register
	lw $t1, 0($t0) #load the first element into $t1, load word with 0 offset
	
# load the next element from the array
	lw $t2, 4($t0) #load second element, since they are words, the offset is 4 bytes
	lw $t3, 8($t0) # 4 bytes passed element 2
	

# add them together, store the results in a register $s0
	add $s0, $t1, $t2  #t0 = t1 + t2
	add $s0, $s0, $t3  # s0 = s0 + t3

# put the result into a label
	sw $s0, result

# print the result 
	# print a string
	li $v0, 4   #print a string
	la $a0, display
	syscall
	
	# print an int
	li $v0, 1
	lw $a0, result  #load result into argument
	syscall

# exit the program
        li $v0, 10      #exit program
	syscall