.include	"stats_calc_macro.asm" 		# Inserts stats_calc_macro.asm into this section

#< - - - - - - - - - - DATA SEGMENT DEFINITION - - - - - - - - - - >#
.data
prompt:		.asciiz 	"Please input 5 integers: "		# Prompt for entering integers
newline: 	.asciiz 	"\n"					# Newline 	
min_prompt: 	.asciiz 	"Minimum: "				# Prompt to display minimum 
max_prompt:	.asciiz 	"Maximum: "				# Prompt to display maximum
sum_prompt: 	.asciiz 	"Sum: "					# Prompt to display sum 
avg_prompt:     .asciiz 	"Average (rounded to integer): "	# Prompt to display average 
range_prompt: 	.asciiz 	"Range: " 				# Prompt to display range


# Allocates 4 bytes of memory for each data value
.align 2
min:	.space 	4		# Initialize empty space for min
max:	.space 	4		# Initialize empty space for max
sum:	.space 	4		# Initialize empty space for sum
avg:	.space	4		# Initialize empty space for average
range:	.space	4		# Initialize empty space for range

.text
main: 
	# Read in user input for 5 integers
	print_string(prompt)		# Print prompt for user input
	read_integer($t0)		# Read user input for integer for $t0
	read_integer($t1)		# Read user input for integer for $t1
	read_integer($t2)		# Read user input for integer for $t2
	read_integer($t3)		# Read user input for integer for $t3
	read_integer($t4)		# Read user input for integer for $t4


	# Find sum 
	add 	$t5, $t0, $zero		# Add $t0 and $zero and place into $t5
	add 	$t5, $t5, $t1		# Add $t1 to $t5
	add 	$t5, $t5, $t2		# Add $t2 to $t5
	add 	$t5, $t5, $t3		# Add $t3 to $t5
	add 	$t5, $t5, $t4		# Add $t4 to $t5
	sw 	$t5, sum		# Stores $t5 into sum
	
	
	# Find average
	lw	$t6, sum		# Loads $t6 with sum 
	li 	$t7, 5 			# Loads $t7 with 5, the count of integers
	div  	$t6, $t7		# Divides $t6 by $7, sum / count
	mflo 	$t6 			# Moves quotient to $t0 
	sw 	$t6, avg		# Stores $t6 into avg
	
	
minimum: 	
	# Find minimum
	
	# Compare first and second number 
	add 	$t6, $t0, $zero		# Initialize $t6 (current min tracker) to value of first integer
	slt 	$t7, $t1, $t6		# Set $t7 to result of $t1 < $t0 (1 if true, 0 if false), compares second number to first number
	beq 	$t7, $zero, min1	# If $t7 is 0 ($t1 is greater than $t0), branch to min1 to skip next line 
	add 	$t6, $t1, $zero		# $t7 is 1 ($t1 is less than $t0), so $t6 stores the smaller number $t1
	
	# Compare third number to current min 
min1:	slt 	$t7, $t2, $t6		# Set $t7 to result of $t2 < $t6, compares third number to current min 
	beq 	$t7, $zero, min2	# If $t7 is 0 (Current min is smaller), branch to min2 to skip next line 
	add 	$t6, $t2, $zero		# $t7 is 1 ($t2 is less than current min), current min updates to third number 
	
	# Compare fourth number to current min 
min2:	slt 	$t7, $t3, $t6		# Set $t7 to result of $t3 < $t6, compares fourth number to current min 
	beq 	$t7, $zero, min3	# If $t7 is 0 (Current min is smaller), branch to min3 to skip next line 
	add 	$t6, $t3, $zero		# Current min updates to fourth number 
	
	# Compare fifth number to current min 
min3:	slt 	$t7, $t4, $t6		# Set $t7 to result of $t4 < $t6, compares fifth number to current min 
	beq 	$t7, $zero, min4	# If $t7 is 0 (Current min is smaller), branch to min4 to skip next line 
	add 	$t6, $t4, $zero		# Current min updates to fifth number 
	
	# Store current min to min 
min4:	sw 	$t6, min		# Stores $t6 into min 


maximum:	
	# Find maximum
	
	# Compare first and second number 
	add 	$t6, $t0, $zero		# Initialize $t6 (current max tracker) to value of first integer
	slt    	$t7, $t0, $t1		# Set $t7 to result of $t0 < $t1 (1 if true, 0 if false), compares first number to second number 
	beq 	$t7, $zero, max1	# If $t7 is 0 ($t0 is greater than $t1), branch to max1 to skip next line 
	add 	$t6, $t1, $zero		# $t7 is 1 ($t1 is greater than $t0), so $t6 stores the larger number $t1  

	# Compare third number to current max
max1:	slt 	$t7, $t6, $t2		# Set $t7 to result of $t6 < $t2, compares current max to third number 
	beq 	$t7, $zero, max2	# If $t7 is 0 (Current max is greater), branch to max2 to skip next line
	add 	$t6, $t2, $zero		# Current max updates to third number 

	# Compare fourth number to current max
max2:	slt 	$t7, $t6, $t3		# Set $t7 to result of $t6 < $t3, compares current max to fourth number 
	beq 	$t7, $zero, max3	# If $t7 is 0 (Current max is greater), branch to max3 to skip next line 
	add 	$t6, $t3, $zero		# Current max updates to fourth number 

	# Compare fifth number to current max 
max3:	slt 	$t7, $t6, $t4		# Set $t7 to result of $t6 < $t4, compares current max to fifth number 
	beq 	$t7, $zero, max4	# If $t7 is 0 (Current max is greater), branch to max4 to skip next line 
	add 	$t6, $t4, $zero		# Current max updates to fifth number 
	
	# Store current max to max
max4:	sw 	$t6, max		# Stores $t6 into max 


	# Find range
	lw $t0, max			# Loads $t0 with max
	lw $t1, min			# Loads $t1 with min
	sub $t8, $t0, $t1		# Subtract max by min and store result into $t8
	sw $t8, range 			# Store $t8 into range
	
	
	# Print sum  
	print_string(sum_prompt)	# Prints "Sum: "
	lw	$t0, sum		# Loads $t0 with sum
	print_integer($t0)		# Prints $t0
	print_string(newline)		# Prints newline 
	
	
	# Print average 
	print_string(avg_prompt)	# Prints "Average: " 
	lw	$t0, avg		# Loads $t0 with avg 
	print_integer($t0)		# Prints $t0
	print_string(newline)		# Prints newline 
	
	
	# Print minimum 
	print_string(min_prompt) 	# Prints "Minimum: "
	lw 	$t0, min 		# Loads $t0 with min 
	print_integer($t0)		# Prints $t0 
	print_string(newline) 		# Prints newline 
	
	
	# Print maximum 
	print_string(max_prompt)	# Prints "Maximum: "
	
	lw 	$t0, max		# Loads $t0 with max
	print_integer($t0)		# Prints $t0 
	print_string(newline)		# Prints newline 
	
	
	# Print range
	print_string(range_prompt)	# Prints "Range: "
	lw	$t0, range		# Loads $t0 with range 
	print_integer($t0)		# Prints $t0 
	print_string(newline)		# Prints newline 


	exit				# Exit program

