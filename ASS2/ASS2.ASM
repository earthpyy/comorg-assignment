        .model tiny

        .data
arr     DB     80 DUP(-1)
seed    DB     ?
seed2   DB     ?

cnt     DB     0

i       DW     ?
j       DW     ?

        .code
        ORG    0100h

main:
        MOV    ah, 00h          ; set video mode
        MOV    al, 03h
        INT    10h

        MOV    ah, 00h          ; get system time as seed
        INT    1Ah
        MOV    seed, dl

        MOV    ah, 00h          ; get system time as seed2
        INT    1Ah
        MOV    seed2, dl

        ; MOV    cx, 80           ; loop for 80 times
mnlp:
        ; PUSH   cx
        CALL   rand80          ; TODO

        MOV    bh, 00h
        MOV    bl, seed
        MOV    di, bx
        MOV    [arr + bx], 0

        MOV    cx, 2            ; do it 3 times
rptlp:
        PUSH   cx

        MOV    i, 0
chklp:

        MOV    di, i
        CMP    [arr + di], -1
        JE     ctn2

; ---------- dummy ----------
        JMP    skip
dmnlp:
        JMP    mnlp
skip:
; ---------- dummy ----------

        MOV    j, 0
pntlp:

        MOV    ah, 02h          ; move cursor to column
        MOV    bx, j

        ; MOV    di, i
        MOV    dx, i
        MOV    dh, bl
        ; MOV    dl,         ; move cursor to random position
        MOV    bh, 0
        INT    10h

        CALL   rand94
        MOV    ah, 0Ah          ; print character
        MOV    al, seed2
        ADD    al, 33
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        INC    j

        MOV    ah, 86h          ; delay
        MOV    cx, 00h
        MOV    dx, 0500h
        INT    15h

        MOV    di, i
        MOV    bh, 00h
        MOV    bl, [arr + di]

        ; CMP    j, 1
        CMP    j, bx
        JLE     pntlp
        ; JMP    ctn3
; end pntlp loop

ctn3:
        MOV    di, i
        INC    [arr + di]

ctn2:
        INC    i
        CMP    i, 80
        JL     chklp
        ; JMP    ctn1
; end chklp loop

ctn1:
        NOP
        POP    cx
        LOOP   rptlp
; end rptlp loop

        JMP   dmnlp
; end mnlp loop

        .exit

rand80 proc near uses ax cx dx

        MOV    ah, 00h
        MOV    al, seed

        MOV    cx, 21           ; linear congruent generator
        MUL    cx
        ADD    ax, 77

        MOV    cx, 80           ; mod 80
        XOR    dx, dx
        DIV    cx

        MOV    seed, dl

        RET

rand80 endp

; rand80n proc near uses ax cx dx
;
;         MOV    ah, 00h
;         MOV    al, seed
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
;         MOV    seed, dl
;
;         RET
;
; rand80n endp

rand94 proc near uses ax cx dx

        MOV    ah, 00h
        MOV    al, seed2

        MOV    cx, 95           ; linear congruent generator
        MUL    cx
        ADD    ax, 17

        MOV    cx, 94           ; mod 94
        XOR    dx, dx
        DIV    cx

        MOV    seed2, dl

        RET

rand94 endp

        RET
        END    main
