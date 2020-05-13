section .data                    	; data section, read-write
        an:    DQ 0              	; this is a temporary var

section .text                    	; our code is always in the .text section
        global do_Str          	    ; makes the function appear in global scope
        extern printf            	; tell linker that printf is defined elsewhere 							; (not used in the program)

do_Str:                        	    ; functions are defined as labels
        push    rbp              	; save Base Pointer (bp) original value
        mov     rbp, rsp         	; use base pointer to access stack contents
        mov rcx, rdi			    ; get function argument

;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE STARTS HERE ;;;;;;;;;;;;;;;; 
	
	jmp start
	
	EqualsOpen: 
		mov byte [rcx], 0x3C
		jmp Before_End_Loop
		
	EqualsClose: 
		mov byte [rcx], 0x3E 
		jmp Before_End_Loop
		
	UpperCase:
		sub  byte [rcx], 0x20
		jmp Before_End_Loop
	
	start:
	
	mov	qword [an], 0		; initialize answer
	Loop_Lable:
	
		mov al, byte [rcx]
		cmp al, 0x41
		jl Start_Conditions
		
		cmp al, 0x5A
		jle Before_End_Loop
		
		cmp al, 0x61
		jl Start_Conditions
		
		cmp al, 0x7A
		jle UpperCase
			
		Start_Conditions:
		
		inc qword [an]
		
		cmp byte [rcx], 0x28 ;'('
		je EqualsOpen
		
		cmp byte [rcx], 0x29 ;')'
		je EqualsClose
		
		Before_End_Loop:
		
		inc rcx      	    ; increment pointer
		cmp byte [rcx], 0   ; check if byte pointed to is zero
		jnz Loop_Lable      ; keep looping until it is null terminated


;;;;;;;;;;;;;;;; FUNCTION EFFECTIVE CODE ENDS HERE ;;;;;;;;;;;;;;;; 

         mov     rax,[an]         ; return an (returned values are in rax)
         mov     rsp, rbp
         pop     rbp
         ret 
		 ;End
