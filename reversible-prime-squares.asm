#==================================================================
# @author: Ramoroke T 201502583
# @purpose: reversible prime square program that are not palidome
# @date: October 2022
# @contact: ramoroketsele@gmail.com
#==================================================================

.data
    promptn: .asciiz "Enter the number of reversible prime squares needed: \n"
    space: .asciiz"    "
    Comma: .asciiz ","


.text
.globl main

main:
    #prompt for number of reversible prime squares needed
    li      $v0, 4
    la      $a0, promptn
	syscall

    #read number of reversible prime squares needed from keyboard and store in reg (scanf) n
	li      $v0, 5
	syscall
	move    $t0, $v0

    #Initialisation of variables a and c
    li      $t1, 0                                  # a = 0
    li      $t2, 2                                  # c = 2

    #First check if numbers needed are met with a while loop  while (a < n)
    while:
        beq		$t1, $t0, exit	                    # if $t0 == $t1 then exit because  a = n else a < n and proceed

    #else check if the number is prime
        prime:
            li			$s0, 2 		                # $s0 = 2  c in prime function 
            sub			$s1, $t2, 1				    # $s1 = $t2 - 1 that is a - 1 in prime function

    #For loop in prime function
            start_loop:
                sle     $s2, $s0, $s1               # $s2 is the statement $s0 < $s1 i.e c <= a - 1 in prime function
                beqz    $s2, end_loop               # end loop if $s2 > $s1 i.e c > a - 1

                #code block
                div		$t2, $s0			        # $t2 / $s0
                mflo	$s3					        # $s3 = floor(2 / $s0) 
                mfhi	$s4					        # $s4 = $t2 mod $s0 

                beq		$s4, 0, notprime	        # if $s4 = 0 then target

                # in prime loop increment of c 
                addi	$s0, $s0, 1			        # $s0 = $s0 + 1

                b start_loop
            end_loop:
    # After finding the prime numbers we square them
            mul     $s5, $s0, $s0                   # this is just b = c * c
            mul     $t4, $s0, $s0                   # this is just b = c * c

    #Then we reverse the squares
            li      $t3, 0
            li      $s8, 10
            while_2:
                beq		$s5, $zero, exit_2      	# if $t0 == $t1 then target
                mul     $t3, $t3, $s8

                div		$s5, $s8		            # $s5 / 10
                mflo	$s6					        # $t2 = floor($s5 / 10) 
                mfhi	$s7				            # $t3 = $s5 mod $10

                add		$t3, $t3, $s7       		# $t3 = $t1 + $t2
                addi	$s5, $s6, 0			        # $t0 = $t1 + 0
                
                j while_2

            exit_2:

    #The we check if reverse and square are palidome
            #if it is
            bne		$t3, $t4, notpaly	            # if $t3 != $t1 then target
            addi	$t2, $t2, 1	
            j while

            notpaly:

    # If not palidome then check the square root of the reverse
            #$t3 is the reverse of $t4 and $t5 should be the root of $t3
            li			$k0, 0				        # $k0 = 0
            li			$v0, 2				        # $r0 = 2
            addi	    $t5, $t3, 0			# $t0 = $t1 + 0
            addi	    $k1, $t3, 0			        # $k1 = $t3 + 0

            while_square_root:
                beq		$k0, 7, exit_square_root	# if $t0 == $t1 then target

                div		$k1, $t5			        # E/C
                mflo	$v1					        # E/C

                add 	$t5, $t5, $v1		        # E/C + C

                div		$t5, $v0			        # $t0 / $t1
                mflo	$a3					        # $t2 = floor($t0 / $t1) 

                addi	$t5, $a3, 0			        # 3 = $t1 + 0

                addi	$k0, $k0, 1			        # $t0 = $t1 + 0

                j		while_square_root			# jump to while_square_root 
                

            exit_square_root:
    #Check if the square Root of the reverse is prime
                #if it is not
                ble		$t5, 1, notprime	            # if $t0 <= $t1 then target

                prime_rev_check:
                    li			$t7, 2				# $k0 = 2
                    sub		    $t6, $t5, 1 		# $t0 = $t1 - $t2
                    

                    start_loop_rev_check:
                        sle     $k1, $t7, $t6               # $s2 is the statement $s0 < $s 1 i.e c <= a - 1 in prime function
                        beqz    $k1, end_loop_rev_check

                        #code block
                        div		$t5, $t7			        # $t2 / $s0
                        mflo	$v0					        # $s3 = floor(2 / $s0) 
                        mfhi	$a3					        # $s4 = $t2 mod $s0 

                        beq		$a3, 0, notprime	        # if $s4 = 0 then target

                        # in prime loop increment of c 
                        addi	$t7, $t7, 1			        # $s0 = $s0 + 1

                        b start_loop_rev_check
                    end_loop_rev_check:               
    # Output the results
            li      $v0, 1
            move    $a0, $t4
            syscall

            li      $v0, 4
            la      $a0, Comma
            syscall

            li      $v0, 1
            move    $a0, $t3
            syscall

    #add some space and a comma in between numbers
            li      $v0, 4
            la      $a0, space
	        syscall


            addi	$s0, $s0, 1			            # $s0 = $s0 + 1 c = c + 1 in prime function


            addi	$t1, $t1, 1			            # $t1 = $t1 + 0 i.e a = a + 1
            
    #if number is not prime
        notprime:
            addi	$t2, $t2, 1			            # $t2 = $t2 + 1 increment c i.e c = c + 1
        
        j while                                     # while a is still less than n repeat
    exit:

    # exit program (return 0)
	li $v0, 10
	syscall
