        ORG $100                ; start the addresses from this point at $100
LIST:   FCB 11,3,8,7,1,9,-3,4,5 ; define the input list of numbers to be sorted
LSTEND: RMB 2                   ; reserve two bytes at the end of the list for swapping/comparing
NVAL:   RMB 2                   ; reserve two bytes for storing the size of the list
STRT:   LDY #lstend             ; load the address of LSTEND to Y
        LEAU -1,y               ; calculate the address just before LSTEND and store it in U (end of the list)
        STU lstend              ; update LSTEND with the new address for the sorting algorithm
        LEAY -list,y            ; calculate the distance from LIST to LSTEND (the size of the list of the current pass)
        STY nval                ; store the count of items to be sorted in nval
        LEAY -1,y               ; decrement Y to adjust for the loop count
LOOP1:  LDX #list               ; initialize X with the address of the LIST (start of the outer loop)
LOOP2:  LDA ,x+                 ; load th eindex of X into accumalator A, then increment X (start of the inner loop)
        CMPA ,x                 ; compare A (current index) with X (the next position)
        BLS next                ; if A less than or the same as X then skip over the swap method
        LDB ,x                  ; load the next value into B
        STA ,x                  ; store the A (current value) into X (next value)
        STB -1,x                ; store the next value (B) into the next position
NEXT:   CMPX lstend             ; compare the current position with the end of the list
        BLO loop2               ; if not at the end of the list then continue to the inner loop
        LEAX -1,x               ; decremetn X to adjust the end point for the next pass 
        STX lstend              ; store the new end point in LSTEND
XEND:   LEAY -1,y               ; decrement Y to count down the number of passes through the list
        BNE loop1               ; if we haven't done (n-1) passes, then go back to the outer loop
RETN:   JMP $D000               ; break
        END                     ; end of the assembler