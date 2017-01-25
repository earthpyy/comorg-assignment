        .model tiny

        .data
row     DB     24               ; row count
col     DB     0                ; column count
drt     DB     1                ; direction (0 = down, 1 = up)

        .code
        ORG    0100h

main:   MOV    ah, 00h          ; set video mode
        MOV    al, 03h
        INT    10h

        MOV    cx, 80           ; set outer loop amount

; outer loop
collp:  PUSH   cx
        MOV    cx, 25           ; set inner loop amount

; inner loop
rowlp:  PUSH   cx

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

        CMP    drt, 0           ; if drt = 0    ; down
        JE     incr             ;   row++
        DEC    row              ; else          ; up
        JMP    cont             ;   row--
incr:   INC    row

cont:   POP    cx
        LOOP   rowlp
; end inner loop

        CMP    drt, 0           ; if drt = 0    ; down
        JE     decr             ;   col--       ; make it 24
        INC    row              ; else          ; up
        JMP    cont2            ;   col++       ; make it 0
decr:   DEC    row

cont2:  POP    cx

        ; invert direction (drt == 0 ? 1 : 0)
        CMP    drt, 0           ; if drt = 0
        JE     change           ;   drt = 1
        DEC    drt              ; else if drt = 1
        JMP    cont3            ;   drt = 0
change: INC    drt

cont3:  INC    col              ; col++
        LOOP   collp
; end outer loop

        MOV    ah, 00h          ; clear screen
        MOV    al, 03h
        INT    10h

        RET
        END    main
