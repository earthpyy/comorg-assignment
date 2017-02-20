        .model tiny

        .data
arrs    DB     80 DUP(-1)
arre    DB     80 DUP(-1)
arrd    DB     80 DUP(0)
seed80  DB     ?
seed94  DB     ?
seed10  DB     ?
color   DB     0Fh, 0Ah, 02h, 07h, 08h
; color   DB     8, 7, 2, 10, 15

i       DW     ?
j       DW     ?
n       DW     ?
cnt     DB     ?

        .code
        ORG    0100h

main:
        MOV    ah, 00h          ; set video mode
        MOV    al, 03h
        INT    10h

        MOV    ah, 00h          ; get system time as seed
        INT    1Ah
        MOV    seed80, dl

        MOV    ah, 86h          ; delay
        MOV    cx, 00h
        MOV    dx, 050h
        INT    15h

        MOV    ah, 00h          ; get system time as seed94
        INT    1Ah
        MOV    seed94, dl

        MOV    ah, 86h          ; delay
        MOV    cx, 00h
        MOV    dx, 050h
        INT    15h

        MOV    ah, 00h          ; get system time as seed94
        INT    1Ah
        MOV    seed10, dl

        ; MOV    cx, 80           ; loop for 80 times
mnlp:
        ; PUSH   cx
        CALL   rand80          ; TODO

        CALL   rand10
        MOV    cl, seed10

        MOV    bh, 00h
        MOV    bl, seed80
        MOV    di, bx

        MOV    [arrs + di], cl
        MOV    [arre + di], cl

        MOV    n, 0            ; do it 3 times
rptlp:
        ; PUSH   cx

        MOV    i, 0
chklp:

        MOV    di, i
        CMP    [arrs + di], -1
        JE     dctn2

        MOV    di, i
        MOV    bh, 00h
        MOV    bl, [arrs + di]
        MOV    j, bx
        MOV    cnt, 0
pntlp:

        MOV    ah, 02h          ; move cursor to column
        MOV    bx, j
        MOV    dx, i            ; move cursor to random position
        MOV    dh, bl
        MOV    bh, 0
        INT    10h

        CALL   rand94
        MOV    ah, 09h          ; print character

        MOV    di, i
        CMP    [arrd + di], 1
        JE     inv

        CALL   pntColor
        MOV    al, seed94
        ADD    al, 33
        JMP    cont
inv:
        MOV    al, 0
        MOV    bl, 00h

cont:
        MOV    bh, 0
        ; MOV    bl, 0Fh
        MOV    cx, 1
        INT    10h

        INC    j

        MOV    ah, 86h          ; delay
        MOV    cx, 00h
        MOV    dx, 0500h
        INT    15h

        INC    cnt
        CMP    cnt, 15
        JGE    reset

        MOV    di, i
        MOV    bh, 00h
        MOV    bl, [arre + di]
        CMP    j, bx
        JLE    pntlp
        JMP    ctn3
; end pntlp loop

; ---------- dummy ----------
        JMP    skip
dctn2:
        JMP    ctn2
dmnlp:
        JMP    mnlp
drptlp:
        JMP    rptlp
dchklp:
        JMP    chklp
skip:
; ---------- dummy ----------

reset:
        MOV    di, i
        NOT    [arrd + di]
        AND    [arrd + di], 01h

        MOV    di, i
        CMP    [arrd + di], 1
        JMP    reset2

        ; CALL   rand10
        ; MOV    bl, seed10
        MOV    di, i
        MOV    [arrs + di], -1
        MOV    di, i
        MOV    [arre + di], -1

        JMP    cont2


reset2:
        MOV    di, i
        MOV    bl, [arre + di]
        SUB    bl, 14
        MOV    di, i
        MOV    [arrs + di], bl
        MOV    di, i
        MOV    [arre + di], bl
        ; JMP    cont2

cont2:
        MOV    di, i
        MOV    bh, 00h
        MOV    bl, [arrs + di]
        MOV    j, bx
        MOV    cnt, 0

        ; JMP    ctn3

ctn3:
        MOV    di, i
        INC    [arre + di]

ctn2:
        INC    i
        CMP    i, 80
        JL     dchklp
        ; JMP    ctn1
; end chklp loop

ctn1:
        ; NOP
        ; POP    cx
        INC    n
        CMP    n, 2
        JL     drptlp
; end rptlp loop

        JMP   dmnlp
; end mnlp loop

        .exit

rand10 proc near uses ax cx dx

        MOV    ah, 00h
        MOV    al, seed10

        MOV    cx, 11           ; linear congruent generator
        MUL    cx
        ADD    ax, 3

        MOV    cx, 10           ; mod 94
        XOR    dx, dx
        DIV    cx

        MOV    seed10, dl

        RET

rand10 endp

rand80 proc near uses ax cx dx

        MOV    ah, 00h
        MOV    al, seed80

        MOV    cx, 21           ; linear congruent generator
        MUL    cx
        ADD    ax, 77

        MOV    cx, 80           ; mod 80
        XOR    dx, dx
        DIV    cx

        MOV    seed80, dl

        RET

rand80 endp

; rand80n proc near uses ax cx dx
;
;         MOV    ah, 00h
;         MOV    al, seed80
;
;         MOV    ah, 00h          ; get system time
;         INT    1Ah
;
;         MUL    dl
;         MOV    al, ah
;         MOV    ah, dl
;
;         MOV    cx, 80           ; mod 80
;         XOR    dx, dx
;         DIV    cx
;
;         MOV    seed80, dl
;
;         RET
;
; rand80n endp

rand94 proc near uses ax cx dx

        MOV    ah, 00h
        MOV    al, seed94

        MOV    cx, 95           ; linear congruent generator
        MUL    cx
        ADD    ax, 17

        MOV    cx, 94           ; mod 94
        XOR    dx, dx
        DIV    cx

        MOV    seed94, dl

        RET

rand94 endp

pntColor proc near uses bx

        CMP    cnt, 13
        JGE    pnt0

        CMP    cnt, 10
        JGE    pnt1

        CMP    cnt, 2
        JGE    pnt2

        CMP    cnt, 1
        JGE    pnt3

        JMP    pnt4


pnt0:
        MOV    bl, [color + 0]
        JMP    fin
pnt1:
        MOV    bl, [color + 1]
        JMP    fin
pnt2:
        MOV    bl, [color + 2]
        JMP    fin
pnt3:
        MOV    bl, [color + 3]
        JMP    fin
pnt4:
        MOV    bl, [color + 4]
        ; JMP    fin
fin:

        RET

pntColor endp

        RET
        END    main
