.data
   filestr: .space 224     # filename for input 
   buffer: .space 256
   save : .space 256
 
   zero: .asciiz "zero"
   one: .asciiz "one"
   two: .asciiz "two"
   three: .asciiz "three"
   four: .asciiz "four"
   five: .asciiz "five"
   six: .asciiz "six"
   seven: .asciiz "seven"
   eight: .asciiz "eight"
   nine: .asciiz "nine"
  numbers: .asciiz "0123456789"

.text
.globl main

main: 
 li $v0, 8 
 la $a0, filestr
 li $a1, 224 #file name can be up to 224-bit characters. 
 syscall 
 jal newline #jump and link newline procedure

  #open file
  li $v0,13
  la $a0 ,filestr 
  li $a1, 0
  syscall
  move $s0,$v0
  
  #read file
  li $v0,14
  move $a0 , $s0
  li $a2 , 256
  la $a1 , buffer
  syscall

  #close file
  li $v0 , 16
  move $a0 , $s0
  syscall
  
 #load adrees of numbers string
 la $a3 ,numbers
 lb $t2, 0($a3)
 syscall
 #load adress of buffer
la $s0, save    # we are just loading adresses
la $s1 ,0($a1)# s1 buffer
syscall

move $t4 ,$zero#i
move $t5 ,$zero#k
  	
    Loop: 
        add $t6,$t4,$s1 # $t2 = buffer + i
	lb $t1 ,0($t6)  # $t1 = save[i]*****************
	add $t8,$s0,$t5 # $t8=outData[k]
	sb $t1,0($t8)

       beq $t1 , $t2, ZERO
       addi $t2, $t2 ,1#load the next number for comparing byte and number 
       beq $t1 , $t2, ONE
       addi $t2, $t2 ,1
       beq $t1 , $t2, TWO
       addi $t2, $t2 ,1
       beq $t1 , $t2, THREE
       addi $t2, $t2 ,1
       beq $t1 , $t2, FOUR
       addi $t2, $t2 ,1  
       beq $t1 , $t2, F�VE
       addi $t2, $t2 ,1
       beq $t1 , $t2, S�X
       addi $t2, $t2 ,1
       beq $t1 , $t2, SEVEN
       se:addi $t2, $t2 ,1
       beq $t1 , $t2, E�GHT
       e:addi $t2, $t2 ,1
       beq $t1 , $t2, N�NE
       n:
 back:   lb $t2, 0($a3) #ilk say�y� y�kle      
       addi $t5,$t5,1 #k++
       addi $t4,$t4,1 #i++
       beq $t1 ,$zero ,end 
       j Loop
   
 ZERO: la $t9,zero
       add $t3,$zero,$zero
       add,$t3,$t3,$t9
       jal comp
 ONE: la $t9,one
      add $t3,$zero,$zero
      add,$t3,$t3,$t9
      jal comp
 TWO:la $t9,two
      add $t3,$zero,$zero
      add,$t3,$t3,$t9
       jal comp
 THREE:la $t9,three
       add $t3,$zero,$zero
       add,$t3,$t3,$t9
       jal comp
 FOUR: la $t9,four
       add $t3,$zero,$zero
       add,$t3,$t3,$t9
       jal comp
 F�VE:la $t9,five
       add $t3,$zero,$zero
       add,$t3,$t3,$t9
       jal comp
 S�X:la $t9,six
      add $t3,$zero,$zero
      add,$t3,$t3,$t9
       jal comp
 SEVEN:la $t9,seven
       add $t3,$zero,$zero
       add,$t3,$t3,$t9
       jal comp
 E�GHT:la $t9,eight
	add $t3,$zero,$zero
	add,$t3,$t3,$t9
       jal comp
 N�NE:la $t9,nine
       add $t3,$zero,$zero
       add,$t3,$t3,$t9
       jal comp

comp:
    add $s3,$s1,$t4
    seq $t7,$t4,$zero   #0.indexteysek t7ye 1 koy
    bne $t7,$zero,cond1 #0. indexse cond1 e git
    
    addi $t7,$zero,1    #t7 ye 1 y�kle
    seq $t7,$t7,$t4     #index 1 ise t7ye 1 koy
    bne $t7 ,$zero ,cond2  #1.indexse cond1 e git
    la $a2,($a1)
    jal length #length procedur�ne git
    addi $t7,$t0,-2   #lengthin iki eksi�ini t7ye y�kle
    beq $t7,$t4,cond3  #buffer�n sonundan bir �ndeysek 3.cond a git
    
    addi $t7,$t0,-1   #lengthin bir eksi�ini t7ye y�kle
    beq $t7,$t4,cond4  #buffer�n sonundaysak  4.cond a git
    beq $zero,$zero ,cond4
    cond2 : #�n�nde say� var m� , sonras�nda ve iki sonras�nda nokta ve say� kontrol�
   lb $s2,  -1($s3)#say�n�n �n�nde say� var m� t6=buffer -1
   
   
    slti  $t7 ,$s2 ,58#say�n�n �n�nde say� varsa else gitsin
    sgt $t0 ,$s2,47
    and $t7 , $t7,$t0 
    bne $t7 ,$zero,else #say� varsa sa�lam�yor else git
    cond1:#yan�nda nokta var m� yan�nda say� var m�
    lb $s2,  1($s3)#say�n�n sonras� t6=buffer +1
    slti $t7 ,$s2 ,58#say�n�n yan�nda say� varsa else gitsi
    sgt $t0 ,$s2,47
    and $t7 , $t7,$t0 
    bne $t7 ,$zero,else # sa�lam�yo ��k
    addi $t0,$zero,46 #nokta ascii karakter
    beq $t0 ,$s2 ,cond5#nokta varsa iki sonras�na say� var m� diye bak
    beq $zero, $zero ,do #�artlar� sa�l�yorsa do'ya gitsin
    cond3:#sondan bir �ndeysek bir sonras�na bak . iki �ncesine kadar kontrol
    lb $s2,1($s3)#say�n�n bir sonras� t6=buffer +1
    slti  $t7 ,$s2 ,58#say�n�n yan�nda say� varsa else gitsin
   sgt $t0 ,$s2,47
    and $t7 , $t7,$t0 
    bne $t7 ,$zero,else #say� varsa sa�lam�yor else git
    cond4:#sondaysak iki �ncesine bak
    lb $s2,-1($s3)#say�n�n �n�nde say� var m� t6=buffer -1
    sltiu  $t7 ,$s2 ,58#say�n�n �n�nde say� varsa else gitsin
    sgt $t0 ,$s2,47
    and $t7,$t7,$t0
    bne $t7 ,$zero,else #say� varsa sa�lam�yor else git
    addi $t0,$zero,46 #nokta ascii karakter
    bne $t0 ,$s2 ,x#nokta varsa iki sonras�na say� var m� diye bak
    lb $s2,  -2($s3)#say�n�n iki �n�nde say� var m� t6=buffer -1
    slti  $t7 ,$s2 ,58#say�n�n iki �n�nde say� varsa else gitsin
    sgt $t0 ,$s2,47
    and $t7 , $t7,$t0 
    bne $t7 ,$zero,else #say� varsa sa�lam�yor else git
    la $a2,($a1)
    x:jal length #length procedur�ne git
    addi $t7,$t0,-1   #lengthin bir eksi�ini t7ye y�kle
    beq $t7,$t4,do #buffer�n sonundaysak  4.cond a git
    cond5:#iki sonraya bak
    lb $s2,  1($s3)#say�n�n �n�nde say� var m� t6=buffer -1
    slti  $t7 ,$s2 ,58#say�n�n �n�nde say� varsa else gitsin
   sgt $t0 ,$s2,47
    and $t7 , $t7,$t0 
    bne $t7 ,$zero,else #say� varsa sa�lam�yor else git
    addi $t0,$zero,46 #nokta ascii karakter
    bne $t0 ,$s2 ,do#nokta varsa iki sonras�na say� var m� diye bak
    lb $s2,  2($s3)#say�n�n iki �n�nde say� var m� t6=buffer -1
    slti  $t7 ,$s2 ,58#say�n�n iki �n�nde say� varsa else gitsin
    sgt $t0 ,$s2,47
    and $t7 , $t7,$t0 
    bne $t7 ,$zero,else #say� varsa sa�lam�yor else git
    beq $zero, $zero ,do #�artlar� sa�l�yorsa do'ya gitsin
   
do : addi $t7, $zero,0
lp: lb $t0,0($t3)	
   beq $t0 , $zero ,else2
   add $t8,$s0,$t5
   
  ##i==0 m�,count==0. bir�ncesi bo�luk mu iki �ncesi nokta m�: t0=t0-32,
   seq $a0,$t7,$zero
   seq $t9,$t4,$zero
   and $t9,$t9,$a0#ji�in
    bne $t9,$zero,upper 
   lb $s2 ,-1($s3)
   seq $a0,$s2,32
   lb $s2 ,-2($s3)
   seq $t9,$s2,46
   and $t9,$t9,$a0
   seq $a0,$t7,$zero
   and $t9,$t9,$a0#ji�in
   bne $t9,$zero,upper    
m: sb $t0,0($t8)
   addi $t5,$t5,1
   addi $t3,$t3,1
   addi $t7, $t7,1
   beq $zero,$zero,lp
 else2:   addi $t5,$t5,-1
  else: j back

upper:addi $t0,$t0,-32
	j m
length:
    addi $t0, $zero, -1 #initialize count 
loop:
    lb $t7, 0($a2) #load the next character to t7
    addi $a2, $a2, 1 #load increment 
    addi $t0, $t0, 1 #increment count
    beqz $t7, exit #end loop if null character is found
    j loop # jump to loop
exit: jr $ra  

 end:
       li $v0, 4
       la $a0,($s0)
        syscall
  li   $v0, 13       # system call for open file
  la   $a0, filestr     # output file name
  li   $a1, 1        # Open for writing (flags are 0: read, 1: write)
  li   $a2, 0        # mode is ignored
  syscall            # open a file (file descriptor returned in $v0)
  move $s6, $v0      # save the file descriptor 
  ###############################################################
  # Write to file just opened
  li   $v0, 15       # system call for write to file
  move $a0, $s6      # file descriptor 
  la   $a1, save   # address of buffer from which to write
  li   $a2, 256       # hardcoded buffer length
  syscall            # write to file
  ###############################################################
  # Close the file 
  li   $v0, 16       # system call for close file
  move $a0, $s6      # file descriptor to close
  syscall            # close file
  li $v0,10
  syscall
   
newline:
    add $t0,$zero,$zero
    add $t1,$t1,$a0
loop2:	
    lb $a3,0($t1)  
    addi $t1, $t1, 1
    bne $a3,$zero,loop2       # Search the NULL char code
    beq $t1, $a1,exit3   # Check whether the buffer was fully loaded
    subi $t1, $t1, 2    # Otherwise 'remove' the last character
    sb $0, 0($t1)     # and put a NULL instead
exit3:jr $ra	
