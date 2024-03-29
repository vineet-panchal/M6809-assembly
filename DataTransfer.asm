      LDA #B                     ; load the A register with the hexdecimal value 11 (the counter for the for loop)
      LDX $200                   ; load the X register with the address $200 (start of the source data)
      LDY $300                   ; load the Y register with the address $300 (address of the transfer place)
LOOP: LDB ,X+                    ; load B by the byte at the address pointed to by X and increment X
      STB ,Y+                    ; store the byte from B to the address pointed toby Y and increment Y
      DECA                       ; decrement A (the loop counter)
      BNE LOOP                   ; if A is not zero then continue to the loop (not all bytes have been transferred)
RETN: JMP $D000                  ; break
      ORG $200                   ; start all the addresss from this point at $200
      FCB 0,1,2,3,4,5,6,7,8,9,$A ; defining the input list
      END                        ; end of the assembler
