        .model tiny

Bj = 2415       ; B low
C = 2280
Ck = 2152       ; C#
D = 2031
Dk = 1917       ; D#
E = 1809
F = 1715
Fk = 1612       ; F#
G = 1521
A = 1355
B = 1207

        .data
;------------------- SETTING -------------------

; delay
easydelay       DW     04h
mediumdelay     DW     02h
harddelay       DW     01h

; length of matrix
len     DB     23       ; [8, 25] (default: 15)

; repeat n time(s) then new column begin
rptN    DW     3       ; default: 10

; variables in linear congruential generator
a80     DW     81       ; a (default: 81)
c80     DW     17       ; c (default: 17)
a36     DW     37       ; a (default: 37)
c36     DW     7       ; c (default: 11)

; colors of matrix
color   DB     0Fh, 0Ah, 02h, 07h, 08h
;-----------------------------------------------

;------------------ VARIABLES ------------------

hptext  DB     ' SCORE:   0                                                              HP: 10$', 0

tittxt  DB     '                  _|_|    _|        _|_|_|    _|    _|    _|_|                 ', 0
        DB     '                _|    _|  _|        _|    _|  _|    _|  _|    _|               ', 0
        DB     '                _|_|_|_|  _|        _|_|_|    _|_|_|_|  _|_|_|_|               ', 0
        DB     '                _|    _|  _|        _|        _|    _|  _|    _|               ', 0
        DB     '                _|    _|  _|_|_|_|  _|        _|    _|  _|    _|               ', 0
        DB     '                                                                               ', 0
        DB     '       _|_|_|  _|    _|    _|_|      _|_|    _|_|_|_|_|  _|_|_|_|  _|_|_|      ', 0
        DB     '     _|        _|    _|  _|    _|  _|    _|      _|      _|        _|    _|    ', 0
        DB     '       _|_|    _|_|_|_|  _|    _|  _|    _|      _|      _|_|_|    _|_|_|      ', 0
        DB     '           _|  _|    _|  _|    _|  _|    _|      _|      _|        _|    _|    ', 0
        DB     '     _|_|_|    _|    _|    _|_|      _|_|        _|      _|_|_|_|  _|    _|    $', 0

anyk    DB     '                          press any key to continue                            $', 0

modetxt DB     '                    _   _   _   _     _   _   _   _   _   _                    ', 0
        DB     '                   / \ / \ / \ / \   / \ / \ / \ / \ / \ / \                   ', 0
        DB     '                  ( M | O | D | E ) ( S | E | L | E | C | T )                  ', 0
        DB     '                   \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/                   ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                      EASY                                     ', 0
        DB     '                                      MEDIUM                                   ', 0
        DB     '                                      HARD                                     ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                                                                               ', 0
        DB     '                         ALPHA SHOOTER  Copyright 2017                         $', 0

overtxt DB     '                        _   _   _   _     _   _   _   _                        ', 0
        DB     '                       / \ / \ / \ / \   / \ / \ / \ / \                       ', 0
        DB     '                      ( G | A | M | E ) ( O | V | E | R )                      ', 0
        DB     '                       \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/                       $', 0

starttune DW     E, 5
        DW     D, 2
        DW     C, 4
        DW     D, 4
        DW     E, 4
        DW     Dk, 1
        DW     E, 4
        DW     Dk, 1
        DW     E, 8

        DW     D, 4
        DW     Ck, 1
        DW     D, 4
        DW     Ck, 1
        DW     D, 8

        DW     E, 4
        DW     G, 4
        DW     Fk, 1
        DW     G, 8

        DW     00h, 00h

overtune DW     E, 5
        DW     D, 2
        DW     C, 4
        DW     D, 4
        DW     E, 4
        DW     Dk, 1
        DW     E, 4
        DW     Dk, 1
        DW     E, 8

        DW     D, 4
        DW     Ck, 1
        DW     D, 4
        DW     E, 4
        DW     D, 4
        DW     C, 8

        DW     00h, 00h

shoottune DW     E, 1

        DW     00h, 00h

arrs    DB     80 DUP(-1)
arre    DB     80 DUP(-1)
arrd    DB     80 DUP(0)
arrc    DB     80 DUP(0)

delay   DW     ?
seed80  DB     ?
seed36  DB     ?

score   DW     0
hp      DB     10

m       DB     0
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

        MOV    ah, 01h
        MOV    cx, 2607h
        INT    10h

        CALL   printtitle

mode:
        MOV    ah, 00h          ; set video mode to 80x25
        MOV    al, 03h
        INT    10h

        MOV    ah, 01h
        MOV    cx, 2607h
        INT    10h

        CALL   modeselect

        CMP    m, 0             ; easy mode
        JNE    checkmode1
        MOV    ax, easydelay
        MOV    delay, ax
        JMP    begin

checkmode1:
        CMP    m, 1             ; medium mode
        JNE    checkmode2
        MOV    ax, mediumdelay
        MOV    delay, ax
        JMP    begin

checkmode2:
        MOV    ax, harddelay
        MOV    delay, ax

begin:
        MOV    ah, 00h          ; set video mode to 80x25
        MOV    al, 03h
        INT    10h

        MOV    ah, 01h
        MOV    cx, 2607h
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
        MOV    seed36, dl

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 0           ;     column 0
        MOV    dh, 24           ;     row 24
        MOV    bh, 0
        INT    10h

        MOV     ah, 09h
        MOV     dx, offset hptext
        INT     21h

        MOV    cx, 80
charlp:
        PUSH   cx
        CALL   rand36
        MOV    dl, seed36
        ADD    dl, 48

        CMP    dl, 58
        JL     skipunused
        ADD    dl, 7

skipunused:
        POP    cx
        DEC    cx
        MOV    si, cx
        MOV    [arrc + si], dl

        MOV    ah, 02h          ; move cursor to
        MOV    dl, cl            ;     column cl
        MOV    dh, 23           ;     row 23 (start row from rand10)
        MOV    bh, 0
        INT    10h

        PUSH   cx
        MOV    ah, 0Ah
        MOV    al, '-'            ; print dash
        MOV    bh, 0
        MOV    cx, 1
        INT    10h
        POP    cx

        INC    cx
        LOOP   charlp

        MOV    round, 0         ; count round
mnlp:
        CALL   rand80           ; get some new random number
        ; MOV    cl, 0

        MOV    bh, 00h
        MOV    bl, seed80
        MOV    di, bx

        MOV    [arrs + di], 0  ; set start/end row of rand80 = rand10
        MOV    [arre + di], 0

        MOV    n, 0
rptlp:
        MOV    allc, 0
        MOV    i, 0
chklp:
        MOV    di, i
        CMP    [arrs + di], -1  ; if start row = -1
        JE     ddctn2            ;     then don't print

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

        ; CALL   rand36           ; get new random character

        MOV    ah, 09h

        MOV    di, i
        CMP    [arrd + di], 1   ; if printed all character in column already
        JE     inv              ;     then print blank character

        CALL   pntColor         ;     else select color to print
        MOV    di, i
        MOV    al, [arrc + di]       ;          and use rand94 character to print
        ; ADD    al, 33
        JMP    cont

inv:
        MOV    al, 0            ; print blank character
        MOV    bl, 00h
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        INC    j
        INC    cnt

        MOV    ah, 02h          ; move cursor to
        MOV    bx, j
        MOV    dx, i            ;     column i
        MOV    dh, bl           ;     row j (start row from rand10)
        MOV    bh, 0
        INT    10h

        MOV    ah, 09h
        MOV    al, 0            ; print blank character
        MOV    bl, 00h
        MOV    bh, 0
        MOV    cx, 1

        CMP    cnt, 22
        JGE     ctn4
        INT    10h

        INC    j
        INC    cnt

;-------------------- DUMMY --------------------
        JMP    skip
ddctn2:
        JMP    dctn2
dpntlp:
        JMP    pntlp
skip:
;-----------------------------------------------

ctn4:
        MOV    ah, 02h          ; move cursor to
        MOV    bx, j
        MOV    dx, i            ;     column i
        MOV    dh, bl           ;     row j (start row from rand10)
        MOV    bh, 0
        INT    10h

        MOV    ah, 09h
        MOV    al, 0            ; print blank character
        MOV    bl, 00h

cont:
        MOV    bh, 0
        MOV    cx, 1
        INT    10h              ; print character

        MOV    ah, 01h          ; check buffer
        INT    16h
        JZ     ctn5

        MOV    ah, 00h          ; get character from buffer
        INT    16h

        CMP    al, 27
        JE     ddexit
        ; call    exit

        MOV    cx, 80
cmplp:
        PUSH   cx
        DEC    cx

        CMP    al, 97
        JL     ctn6
        CMP    al, 122
        JG     ctn6
        SUB    al, 32

ctn6:
        MOV    di, cx
        CMP    [arrc + di], al
        JNE    ctn7
        MOV    di, cx
        CMP    [arrs + di], -1
        JNE    incsc

ctn7:
        POP    cx
        LOOP   cmplp

ctn5:
        INC    j
        INC    cnt
        MOV    bl, len
        MOV    di, i
        CMP    cnt, bl          ; if printed all character in column already
        JGE    dechp            ;     then reset column

        MOV    di, i
        MOV    bh, 00h
        MOV    bl, [arre + di]
        CMP    j, bx            ; if not print to end of row to print yet
        JLE    dpntlp            ;     then continue printing
        JMP    ctn3             ;     else print next column
; end pntlp loop

incsc:
        INC    score

        CALL   shootsound

        XOR    dx, dx
        MOV    ax, score
        MOV    cx, 100
        DIV    cx
        PUSH   dx

        CMP    al, 0
        JE     ctn8

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 8            ;     column 8
        MOV    dh, 24           ;     row 24
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah
        ; MOV    al, al            ; print score MSB
        ADD    al, '0'
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

;-------------------- DUMMY --------------------
        JMP    skip3
ddexit:
        JMP    dexit
skip3:
;-----------------------------------------------

ctn8:
        POP    ax
        XOR    dx, dx
        MOV    cx, 10
        DIV    cx
        PUSH   dx

        CMP    al, 0
        JE     ctn9

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 9            ;     column 8
        MOV    dh, 24           ;     row 24
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah
        ; MOV    al, al            ; print score
        ADD    al, '0'
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

ctn9:
        POP    ax

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 10            ;     column 10
        MOV    dh, 24           ;     row 24
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah
        ; MOV    al, al            ; print score
        ADD    al, '0'
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        JMP    reset

dechp:
        DEC    hp

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 77            ;     column 77
        MOV    dh, 24           ;     row 24
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah
        MOV    al, 0            ; print blank character
        ; ADD    al, '0'
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 78            ;     column 78
        MOV    dh, 24           ;     row 24
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah
        MOV    al, hp            ; print hp
        ADD    al, '0'
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        CMP    hp, 0
        JE     dexit

reset:
        MOV    [arrs + di], -1  ; reset start row of column i
        MOV    [arre + di], -1  ; reset end row of column i

        MOV    cx, 23
dellp:
        PUSH   cx
        DEC    cx
        MOV    ah, 02h          ; move cursor to
        MOV    bx, cx
        MOV    dx, di            ;     column i
        MOV    dh, bl           ;     row cx
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah
        MOV    al, 0            ; print blank character
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        POP    cx
        LOOP   dellp
; end dellp loop

        JMP    cont2

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
dctn2:
        JMP    ctn2
dexit:
        JMP    exit
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
        MOV    cx, 2000
        SUB    cx, allc         ; 2000 - printed character

dummy:
        PUSH   cx

        MOV    ah, 02h          ; move cursor
        MOV    dh, 24
        MOV    dl, 40
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

        MOV    ah, 86h          ; difficult delay
        MOV    cx, delay
        MOV    dx, 00h
        INT    15h

        INC    n
        MOV    bx, rptN
        CMP    n, bx            ; if n < rptN
        JL     drptlp           ;     then repeat printing

        JMP   dmnlp
; end mnlp loop

exit:
        MOV    ah, 00h          ; set video mode to 80x25
        MOV    al, 03h
        INT    10h

        MOV    ah, 01h
        MOV    cx, 2607h
        INT    10h

        CALL   printover

        RET
        .exit

delaytest:
        MOV    ah, 86h          ; some delay
        MOV    cx, 05h
        MOV    dx, 00h
        INT    15h

        RET

;------------------ RANDOM FN ------------------

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

; mod 36 random
rand36:
        MOV    ah, 00h
        MOV    al, seed36

        MOV    cx, a36           ; linear congruential generator
        MUL    cx
        ADD    ax, c36



        MOV    cx, 36           ; mod 36
        XOR    dx, dx
        DIV    cx

        MOV    seed36, dl

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

;----------------- PRINT TITLE -----------------

printtitle:
        MOV    ah, 02h          ; move cursor to
        MOV    dl, 0           ;     column 0
        MOV    dh, 7           ;     row 7
        MOV    bh, 0
        INT    10h

        MOV     ah, 09h
        MOV     dx, offset tittxt
        INT     21h

        CALL   startsound

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 0           ;     column 0
        MOV    dh, 21           ;     row 21
        MOV    bh, 0
        INT    10h

        MOV     ah, 09h
        MOV     dx, offset anyk
        INT     21h

pntany:
        MOV    ah, 02h          ; move cursor to
        MOV    dl, 51           ;     column 51
        ADD    dl, bl
        MOV    dh, 21           ;     row 21
        MOV    bh, 0
        INT    10h

        MOV     ah, 0Ah
        MOV     al, '.'
        MOV     bh, 0
        MOV     cx, 1
        INT     10h

        MOV    ah, 01h
        INT    16h
        JNZ    exitany
        CALL   delaytest

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 52           ;     column 52
        ADD    dl, bl
        MOV    dh, 21           ;     row 21
        MOV    bh, 0
        INT    10h

        MOV     ah, 0Ah
        MOV     al, '.'
        MOV     bh, 0
        MOV     cx, 1
        INT     10h

        MOV    ah, 01h
        INT    16h
        JNZ    exitany
        CALL   delaytest

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 51           ;     column 51
        ADD    dl, bl
        MOV    dh, 21           ;     row 21
        MOV    bh, 0
        INT    10h

        MOV     ah, 0Ah
        MOV     al, 0
        MOV     bh, 0
        MOV     cx, 1
        INT     10h

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 52           ;     column 52
        ADD    dl, bl
        MOV    dh, 21           ;     row 21
        MOV    bh, 0
        INT    10h

        MOV     ah, 0Ah
        MOV     al, 0
        MOV     bh, 0
        MOV     cx, 1
        INT     10h

        MOV    ah, 01h
        INT    16h
        JNZ    exitany
        CALL   delaytest

        JMP    pntany

exitany:
        MOV    ah, 00h
        INT    16h
        RET

modeselect:
        MOV    ah, 02h          ; move cursor to
        MOV    dl, 0           ;     column 0
        MOV    dh, 5           ;     row 5
        MOV    bh, 0
        INT    10h

        MOV     ah, 09h
        MOV     dx, offset modetxt
        INT     21h

        MOV    ah, 02h          ; move cursor to
        MOV    dl, 36           ;     column 36
        MOV    dh, 12           ;     row 12
        MOV    bh, 0
        INT    10h

        MOV    ah, 0Ah
        MOV    al, 0
        MOV    bh, 0
        MOV    cx, 1
        INT    10h

        MOV    ah, 02h          ; move cursor to
        MOV    dh, 13           ;     row 13
        INT    10h

        MOV    ah, 0Ah
        INT    10h

        MOV    ah, 02h          ; move cursor to
        MOV    dh, 14           ;     row 14
        INT    10h

        MOV    ah, 0Ah
        INT    10h

        MOV    ah, 02h          ; move cursor to
        MOV    dh, 12           ;     row 12
        ADD    dh, m
        INT    10h

        MOV    ah, 0Ah
        MOV    al, '>'
        INT    10h

inflp:
        MOV    ah, 01h
        INT    16h
        JZ     inflp

        MOV    ah, 00h
        INT    16h

checkup:
        CMP    ah, 72           ; arrow up
        JNE    checkdown

        CMP    m, 0
        JE     inflp
        DEC    m
        JMP    modeselect

checkdown:
        CMP    ah, 80           ; arrow down
        JNE    checkenter

        CMP    m, 2
        JE     inflp
        INC    m
        JMP    modeselect

checkenter:
        CMP    al, 13           ; carriage return
        JNE    inflp

        RET

startsound:
        push ds
        pop  es
        mov  si, offset starttune

        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0B6h                 ;
        out  dx,al                   ;

LoopIt: lodsw                        ; load desired freq.
        or   ax,ax                   ; if freq. = 0 then done
        jz   short LDone             ;
        mov  dx,42h                  ; port to out
        out  dx,al                   ; out low order
        xchg ah,al                   ;
        out  dx,al                   ; out high order
        lodsw                        ; get duration
        mov  cx,ax                   ; put it in cx (16 = 1 second)
        call PauseIt                 ; pause it
        jmp  short LoopIt

LDone:  mov  dx,61h                  ; turn speaker off
        in   al,dx                   ;
        and  al,0FCh                 ;
        out  dx,al                   ;

        RET

PauseIt:
        MOV    ah, 86h
        ; MOV    cx, 00h
        MOV    dx, 00h
        INT    15h

        RET

printover:
        MOV    ah, 02h          ; move cursor to
        MOV    dl, 0           ;     column 0
        MOV    dh, 9           ;     row 9
        MOV    bh, 0
        INT    10h

        MOV     ah, 09h
        MOV     dx, offset overtxt
        INT     21h

        CALL   oversound

        RET

oversound:
        push ds
        pop  es
        mov  si, offset overtune

        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0B6h                 ;
        out  dx,al                   ;

        CALL   LoopIt

        RET

shootsound:
        push ds
        pop  es
        mov  si, offset shoottune

        mov  dx,61h                  ; turn speaker on
        in   al,dx                   ;
        or   al,03h                  ;
        out  dx,al                   ;
        mov  dx,43h                  ; get the timer ready
        mov  al,0B6h                 ;
        out  dx,al                   ;

        CALL   LoopIt

        RET

        END    main
