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

        MOV    cx, 80           ; loop for 80 times
lp:
        PUSH   cx
        call   rand80

        PUSH   ax
        PUSH   dx

        MOV    ah, 02h          ; move cursor to column
        MOV    dh, 0
        ; MOV    dl, col        ; move cursor to random position
        MOV    bh, 0
        INT    10h

        POP    dx

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

        .exit

rand80 proc near uses ax cx dx

        MOV    cx, 41           ; linear congruent generator
        MUL    cx
        ADD    ax, 27

        MOV    cx, 80           ; mod 80
        XOR    dx, dx
        DIV    cx

        MOV    ax, dx

        RET

rand80 endp

rand94 proc near uses ax cx dx

        MOV    cx, 95           ; linear congruent generator
        MUL    cx
        ADD    ax, 17

        MOV    cx, 94           ; mod 80
        XOR    dx, dx
        DIV    cx

        MOV    ax, dx

        RET

rand94 endp

        RET
        END    main
