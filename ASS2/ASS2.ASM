        .model tiny

        .data
arr     DW     80 DUP(-1)
col     DB     0

        .code
        ORG    0100h

main:
        MOV    ah, 00h          ; set video mode
        MOV    al, 03h
        INT    10h

        MOV    ah, 00h          ; get system time
        INT    1Ah

        MOV    ax, dx

        MOV    cx, 80

        call   testt

        .exit

testt proc near uses cx,ax
lp:
        PUSH   cx

        MOV    cx, 21           ; linear congruent generator
        MUL    cx
        ADD    ax, 17

        MOV    cx, 80           ; mod 80
        XOR    dx, dx
        DIV    cx

        ; MOV    ax, dx
        ; PUSH   ax
        ; PUSH   dx

        PUSH   dx

        MOV    ah, 02h          ; move cursor to column
        MOV    dh, 0
        MOV    dl, col
        MOV    bh, 0
        INT    10h

        POP    dx
        PUSH   dx

        MOV    ah, 0Ah          ; print character
        MOV    al, dl
        ADD    al, 33
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        MOV    ah, 86h          ; delay
        MOV    cx, 01h
        MOV    dx, 00h
        INT    15h

        POP    ax

        INC    col
        POP    cx
        LOOP   lp
testt endp

RET
END    main
