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
	print_string(prompt)	# Print prompt for user input
	read_integer($t0)	# Read user input for integer for $t0
	read_integer($t1)	# Read user input for integer for $t1
	read_integer($t2)	# Read user input for integer for $t2
	read_integer($t3)	# Read user input for integer for $t3
	read_integer($t4)	# Read user input for integer for $t4

	#find minimum
	add $t6, $t0, $zero	#register $t6 stores smallest number
	slt $t7, $t1, $t0	#$t7 stores result of $t1 < $t0
	beq $t7, $zero, SKIP1	#if $t7 is zero ($t1 is greater than $t0), branch to SKIP1
	add $t6, $t1, $zero	#$t7 is one ($t1 is less than $t0), so $t6 stores the smaller number $t1
SKIP1:	slt $t7, $t2, $t6	#$t7 stores result of $t2 < $t6
	beq $t7, $zero, SKIP2
	add $t6, $t2, $zero	#$t6 stores $t2 if true
SKIP2:	slt $t7, $t3, $t6	#$t3 < $t6
	beq $t7, $zero, SKIP3
	add $t6, $t3, $zero	#$t6 stores $t3 if true
SKIP3:	slt $t7, $t4, $t6	#$t4 < $t6
	beq $t7, $zero, SKIP4
	add $t6, $t4, $zero	#$t6 stores $t4 if true
SKIP4:	sw $t6, min
	print_string(min_prompt)
	print_integer($t6)

	# Find sum 
	add 	$t5, $t0, $zero		# Add $t0 and $zero and place into $t5
	add 	$t5, $t5, $t1		# Add $t1 to $t5
	add 	$t5, $t5, $t2		# Add $t2 to $t5
	add 	$t5, $t5, $t3		# Add $t3 to $t5
	add 	$t5, $t5, $t4		# Add $t4 to $t5
	sw 	$t5, sum		# Stores $t5 into sum
	
	# Find average
	lw	$t0, sum	
	li 	$t1, 5 
	div  	$t0, $t1
	mflo 	$t0 
	sw 	$t0, avg 
	
	# Print sum  
	print_string(sum_prompt)
	lw	$t0, sum		# Loads $t0 with sum
	print_integer($t0)		# Prints $t0
	print_string(newline)
	
	# Print average 
	print_string(avg_prompt)
	lw	$t0, avg
	print_integer($t0)

	exit				# Exit program