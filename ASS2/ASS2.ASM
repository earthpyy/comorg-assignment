        .model tiny

        .data
;------------------- SETTING -------------------
; length of matrix
len     DB     15       ; [8, 25] (default: 15)

; repeat n time(s) then new column begin
rptN    DW     10       ; default: 10

; variables in linear congruential generator
a80     DW     81       ; a (default: 81)
c80     DW     17       ; c (default: 17)
a10     DW     11       ; a (default: 11)
c10     DW     3        ; c (default: 3)

; colors of matrix
color   DB     0Fh, 0Ah, 02h, 07h, 08h
;-----------------------------------------------

;------------------ VARIABLES ------------------
arrs    DB     80 DUP(-1)
arre    DB     80 DUP(-1)
arrd    DB     80 DUP(0)

seed80  DB     ?
seed94  DB     ?
seed10  DB     ?

i       DW     ?
j       DW     ?
n       DW     ?
allc    DW     ?
cnt     DB     ?
round   DB     ?
;-----------------------------------------------

        .code
        ORG    0100h

main:
        MOV    ah, 00h          ; set video mode to 80x25
        MOV    al, 03h
        INT    10h

rand:
        MOV    ah, 00h          ; get system time as seed of seed80
        INT    1Ah
        MOV    seed80, dl

        MOV    ah, 86h          ; some delay
        MOV    cx, 00h
        MOV    dx, 050h
        INT    15h

        MOV    ah, 00h          ; get system time as seed of seed94
        INT    1Ah
        MOV    seed94, dl

        MOV    ah, 86h          ; some delay
        MOV    cx, 00h
        MOV    dx, 050h
        INT    15h

        MOV    ah, 00h          ; get system time as seed of seed10
        INT    1Ah
        MOV    seed10, dl

        MOV    round, 0         ; count round
mnlp:
        CALL   rand80           ; get some new random number
        CALL   rand10
        MOV    cl, seed10

        MOV    bh, 00h
        MOV    bl, seed80
        MOV    di, bx

        MOV    [arrs + di], cl  ; set start/end row of rand80 = rand10
        MOV    [arre + di], cl

        MOV    n, 0
rptlp:
        MOV    allc, 0
        MOV    i, 0
chklp:
        MOV    di, i
        CMP    [arrs + di], -1  ; if start row = -1
        JE     dctn2            ;     then don't print

        MOV    bh, 00h          ;     else set j to start row
        MOV    bl, [arrs + di]
        MOV    j, bx
        MOV    cnt, 0
pntlp:

        MOV    ah, 02h          ; move cursor to
        MOV    bx, j
        MOV    dx, i            ;     column i
        MOV    dh, bl           ;     row j (start row from rand10)
        MOV    bh, 0
        INT    10h

        CALL   rand94           ; get new random character

        MOV    ah, 09h

        MOV    di, i
        CMP    [arrd + di], 1   ; if printed all character in column already
        JE     inv              ;     then print blank character

        CALL   pntColor         ;     else select color to print
        MOV    al, seed94       ;          and use rand94 character to print
        ADD    al, 33
        JMP    cont
inv:
        MOV    al, 0            ; print blank character
        MOV    bl, 00h

cont:
        MOV    bh, 0
        MOV    cx, 1
        INT    10h              ; print character

        INC    j
        INC    cnt
        MOV    bl, len
        CMP    cnt, bl          ; if printed all character in column already
        JGE    reset            ;     then reset column

        MOV    di, i
        MOV    bh, 00h
        MOV    bl, [arre + di]
        CMP    j, bx            ; if not print to end of row to print yet
        JLE    pntlp            ;     then continue printing
        JMP    ctn3             ;     else print next column
; end pntlp loop

;-------------------- DUMMY --------------------
        JMP    skip
dctn2:
        JMP    ctn2
skip:
;-----------------------------------------------

reset:
        MOV    di, i
        NOT    [arrd + di]      ; invert arrd[i]
        AND    [arrd + di], 01h

        CMP    [arrd + di], 1   ; if arrd[i] = 1
        JMP    reset2           ;     then goto reset2

        MOV    [arrs + di], -1  ; reset start row of column i
        MOV    [arre + di], -1  ; reset end row of column i

        JMP    cont2

reset2:
        MOV    di, i
        MOV    bl, [arre + di]  ; set new start/end of column
        SUB    bl, len
        ADD    bl, 1

        MOV    [arrs + di], bl  ; to arre - len + 1
        MOV    [arre + di], bl

cont2:
        MOV    di, i
        MOV    bh, 00h
        MOV    bl, [arrs + di]  ; set start row to arrs[i]
        MOV    j, bx

        MOV    bh, 00h
        MOV    bl, cnt
        ADD    allc, bx         ; count printed character
        MOV    cnt, 0           ; reset count

;-------------------- DUMMY --------------------
        JMP    skip2
dmnlp:
        JMP    mnlp
drptlp:
        JMP    rptlp
dchklp:
        JMP    chklp
drand:
        JMP    rand
skip2:
;-----------------------------------------------

ctn3:
        MOV    bh, 00h
        MOV    bl, cnt
        ADD    allc, bx         ; count printed character

        MOV    di, i
        INC    [arre + di]      ; arre[i]++

ctn2:
        INC    i
        CMP    i, 80            ; if i < 80
        JL     dchklp           ;     then continue printing
; end chklp loop

ctn1:
        MOV    cx, 5000
        SUB    cx, allc         ; 5000 - printed character

dummy:
        PUSH   cx

        MOV    ah, 02h          ; move cursor
        MOV    dh, 0
        MOV    dl, 0
        MOV    bh, 0
        INT    10h

        MOV    ah, 09h          ; print character
        MOV    al, 0
        MOV    bl, 00h
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        POP    cx
        LOOP   dummy

        INC    n
        MOV    bx, rptN
        CMP    n, bx            ; if n < rptN
        JL     drptlp           ;     then repeat printing

        JMP   dmnlp
; end mnlp loop

        .exit

;------------------ RANDOM FN ------------------
; mod 10 random
rand10:
        MOV    ah, 00h
        MOV    al, seed10

        MOV    cx, a10           ; linear congruential generator
        MUL    cx
        ADD    ax, c10

        MOV    cx, 10            ; mod 10
        XOR    dx, dx
        DIV    cx

        MOV    seed10, dl

        RET

; mod 80 random
rand80:
        MOV    ah, 00h
        MOV    al, seed80

        MOV    cx, a80           ; linear congruential generator
        MUL    cx
        ADD    ax, c80

        MOV    cx, 80            ; mod 80
        XOR    dx, dx
        DIV    cx

        MOV    seed80, dl

        RET

; mod 94 random
rand94:
        MOV    ah, 00h
        MOV    al, seed94

        MOV    cx, 95           ; linear congruential generator
        MUL    cx
        ADD    ax, 17



        MOV    cx, 94           ; mod 94
        XOR    dx, dx
        DIV    cx

        MOV    seed94, dl

        RET
;-----------------------------------------------

;------------------ PRINT FN -------------------
pntColor:

        MOV    bl, len
        SUB    bl, 2
        CMP    cnt, bl          ; if j = [len-2, len]
        JGE    pnt0             ;     then print color 0

        MOV    bl, len
        SUB    bl, 5
        CMP    cnt, bl          ; else if j = [len-5, len-3]
        JGE    pnt1             ;     print color 1

        CMP    cnt, 2           ; else if j = [2, len-6]
        JGE    pnt2             ;     print color 2

        CMP    cnt, 1           ; else if j = 1
        JGE    pnt3             ;     print color 3

        JMP    pnt4             ; else print color 4


pnt0:
        MOV    bl, [color + 0]  ; set bl to color 0
        JMP    fin
pnt1:
        MOV    bl, [color + 1]  ; set bl to color 1
        JMP    fin
pnt2:
        MOV    bl, [color + 2]  ; set bl to color 2
        JMP    fin
pnt3:
        MOV    bl, [color + 3]  ; set bl to color 3
        JMP    fin
pnt4:
        MOV    bl, [color + 4]  ; set bl to color 4

fin:
        RET
;-----------------------------------------------

        END    main
