# Maitland Andrus
# bitwise shifting and ANDing
# 6/6/2023

# labels go here
.data





# code goes here
.text

	li $t0, 0xABCDABCD
	li $t1, 0x1234FEDC
	
	
	# shift left
	sll $t4, $t0, 4 # shift left logical by 4
	sll  $t4, $t0, 3 # shift left logical by 3
	sll $t4, $t0, 7 # shift left logical by a 7
	
	# shift right
	srl $t3, $t0, 4 # shift right logical by 4 
	srl $t5, $t1, 11 # shift right by 11
	#My turn, shift right by 6
	srl $t5, $t0, 6
	
	
#----------ISOLATE the BITS------------------------------------------------

	li $s0, 0xFC000000
	# 1111 1100 0000 0000 0000 0000 0000 0000
	# isolate bits 31-26
	srl $s1, $s0, 26
	# s1 = 3F
	
	li $s2, 0xABCDEF12
	# what if I want the most signiific bit
	# isolate the 31 bit
	srl $s1, $s2, 31
	
	# What if we want bits 30 - 23
	# isolate bits 30-23 in $s2
	# bits 30 - 23: 010 1011 1    0b0101 0111 0x57	
	
	#sll by 1, then srl by 24
	sll $s3, $s2, 1
	srl $s3, $s3, 24
	
	# isolate bits 30 - 23
	# 0111 1111 1000 0000 0000 0000 0000 0000
	# andi with this hex number: 7F800000
	# shift right by 23 
	andi $s4, $s2, 0x7F800000
	# end up with 0010 1011 1000 0000 0000 0000 0000 0000 = 0x2B80
	srl $s4, $s4, 23
	
	
	
	
	
	
	
