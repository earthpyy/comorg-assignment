        .model tiny

        .data
row     DB     0                ; row count
col     DB     0                ; column count
drt     DB     0                ; direction (0 = forward, 1 = backward)

        .code
        ORG    0100h

main:   MOV    ah, 00h          ; set video mode
        MOV    al, 03h
        INT    10h

        MOV    cx, 25           ; set outer loop amount

; outer loop
rowlp:  PUSH   cx
        MOV    cx, 80           ; set inner loop amount

; inner loop
collp:  PUSH   cx

        MOV    ah, 02h          ; move cursor to x, y
        MOV    dh, row
        MOV    dl, col
        MOV    bh, 00h
        INT    10h

        MOV    ah, 0Ah          ; print 'a'
        MOV    al, 'a'
        MOV    bh, 00h
        MOV    cx, 01h
        INT    10h

        MOV    ah, 86h          ; delay 5000ms
        MOV    cx, 00h
        MOV    dx, 01388h
        INT    15h

        CMP    drt, 0           ; if drt = 0    ; forward
        JE     incr             ;   col++
        DEC    col              ; else          ; backward
        JMP    cont             ;   col--
incr:   INC    col

cont:   POP    cx
        LOOP   collp
; end inner loop

        CMP    drt, 0           ; if drt = 0    ; forward
        JE     decr             ;   col--       ; make it 79
        INC    col              ; else          ; backward
        JMP    cont2            ;   col++       ; make it 0
decr:   DEC    col

cont2:  POP    cx

        ; invert direction (drt == 0 ? 1 : 0)
        CMP    drt, 0           ; if drt = 0
        JE     change           ;   drt = 1
        DEC    drt              ; else if drt = 1
        JMP    cont3            ;   drt = 0
change: INC    drt

cont3:  INC    row              ; row++
        LOOP   rowlp
; end outer loop

        MOV    ah, 00h          ; clear screen
        MOV    al, 03h
        INT    10h

        RET
        END    main
