.text
	#< - - - - - - - - - -  MACRO DEFINITIONS - - - - - - - - - - >#
	# Macro: prints string at given label
	.macro print_string(%label) 		# Usage: print_string(<label of string to print>)
		li $v0, 4			# Load $v0 with 4; to print string 
		la $a0, %label			# Load $a0 with label of string to print 
		syscall				# Syscall to print string
	.end_macro 				# End of macro 

	# Macro: prints integer at given register
	.macro print_integer(%reg)		# Usage: print_integer(<register of integer to print>)
		li $v0, 1			# Load $v0 with 1; to print integer
		move $a0, %reg			# Move register with integer to print to $a0
		syscall 			# Syscall to print integer
	.end_macro 				# End of macro 

	# Macro: reads an integer into a given register
	.macro read_integer(%reg)		# Usage: read_integer(<register to store integer>)
		li $v0, 5			# Load $v0 with 5; to read integer
		syscall				# Syscall to read integer
		addu %reg, $v0, $zero		# Moves integer to desired register 
	.end_macro 				# End of macro 

	# Macro: terminates program
	.macro exit				# Usage: terminate program
		li $v0, 10			# Load $v0 with 10; to 
		syscall 			# Syscall to terminate program 
	.end_macro				# End of macro
