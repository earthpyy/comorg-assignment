            .model tiny

            .data
pFrame      DB     219, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 219
            DB     219, '                                                                              ', 219
            DB     219, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 220, 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                                                                              ', 219
            ; DB     219, '                                                                              ', 219
            DB     223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, 223, '$', 0

storeName   DB     'CE REST-TAURANT$', 0

mS_order    DB     'Order Food!$', 0
mS_game     DB     'Games$', 0
mS_call     DB     'Call waiter/waitress$', 0
mS_bill     DB     'Bill$', 0

back        DB     '[Back]$', 0
confirm     DB     'Are you sure?', 0
con_yes     DB     'YES :)$', 0
con_no      DB     'NO :($', 0

foodType    DB     219, '                             Chef Recommended!                                ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             Popular Dishes                                   ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             New Items                                        ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             View All                                         ', 219, '$', 0

; foodList    DB     'Spicy Beef Nacho$', 0
;             DB     'Double Cheeze Pizza$', 0
;             DB     'Chicken Kabab$', 0
;
; foodListLenA DB    3
; foodListLen DB     18, 21, 15

; fL_chefA    DB     4
fL_chef     DB     1, 2, 6, 8, -1

Vrow        DB     ?
Vcol        DB     ?
Vam         DB     ?
Vam2        DB     ?
i           DB     ?
j           DB     ?
m           DB     ?
n           DB     ?

Vnum        DW     ?

foodFile    DB     "X:\PROJ\COMORG~1\ASS5\TXT\FOODLIST.TXT", 0
foodFile2   DB     "X:\PROJ\COMORG~1\ASS5\TXT\FOOD2.TXT", 0
buf         DB     ?
buf2        DB     ?

            .code
            ORG    0100h

main:
            MOV    ah, 00h                  ; set video mode to 80x25
            MOV    al, 03h
            INT    10h

            MOV    ah, 01h                  ; hide cursor
            MOV    cx, 2607h
            INT    10h

            MOV    dx, offset pFrame
            CALL   pntTxt

            MOV    Vrow, 01h
            MOV    Vcol, 02h
            CALL   moveCursor

            MOV    dx, offset storeName
            CALL   pntTxt

page2:
            MOV    ah, 05h
            MOV    al, 01h
            INT    10h

            MOV    dx, offset pFrame
            CALL   pntTxt

            MOV    Vrow, 01h
            MOV    Vcol, 02h
            CALL   moveCursor2

            MOV    dx, offset storeName
            CALL   pntTxt

            CALL   inf

            ; MOV    ah, 05h
            ; MOV    al, 00h
            ; INT    10h

startp:
            CALL   pntMenu

            MOV    Vrow, 7
            MOV    Vam, 4
            CALL   makeArrow

            ; menu selected
            CMP    m, 2
            JNE    startp_0
            CALL   mCall
            JMP    startp
startp_0:
            CALL   changeScr

            CMP    m, 0
            JNE    startp_1
            CALL   mOrder
            JMP    startp
startp_1:
            CMP    m, 1
            JNE    startp_2
            CALL   mGame
            JMP    startp
startp_2:
            CALL   mBill
            JMP    startp

            RET

mOrder:
            CALL   pntFoodType

            MOV    Vrow, 7
            MOV    Vam, 5
            CALL   makeArrow

            ; food type selected
            CALL   changeScr

            CMP    m, 0
            JNE    mOrder_0
            CALL   moChef
            JMP    mOrder
mOrder_0:
            ;
            ; CMP    m, 1
            ; JNE    mOrder_1
            ; CALL   moPop
            ; JMP    mOrder
; mOrder_1:
            ; CMP    m, 2
            ; JNE    mOrder_2
            ; CALL   moNew
            ; JMP    mOrder
; mOrder_2:
            CALL   moAll
            JMP    mOrder

            RET

; moChef:
;             MOV    ah, 3Dh
;             MOV    dx, offset foodFile2
;             MOV    al, 00h
;             INT    21h
;
;             MOV    bx, ax
;
;             MOV    ah, 3Fh
;             MOV    cx, 1000
;             MOV    dx, offset buf
;             INT    21h
;
;             MOV    di, 0
;             MOV    i, 0
;             MOV    Vcol, 10
;
; moChef_lp:
;             MOV    al, i
;             MOV    ah, 2
;             MUL    ah
;
;             MOV    Vrow, 5
;             ADD    Vrow, al
;             CALL   moveCursor
;
;             CALL   pntBuf
;
;             INC    i
;
;             CMP    i, 9
;             JL     moChef_lp_con
;             MOV    i, 0
;             MOV    Vcol, 50
;
; moChef_lp_con:
;             CMP    buf[di], '#'
;             JNE    moChef_lp
;
;             MOV    Vam, 5
;             MOV    Vam2, 0
;             CALL   makeArrow2
;
;             MOV    ah, 3Eh
;             INT    21h
;
;
;             CALL   inf  ; temp
;             RET

moChef:
            MOV    ah, 3Dh
            MOV    dx, offset foodFile
            MOV    al, 00h
            INT    21h

            MOV    bx, ax

            MOV    ah, 3Fh
            MOV    cx, 1000
            MOV    dx, offset buf
            INT    21h

            MOV    di, 0
            MOV    i, 0
            MOV    j, 0
            MOV    Vcol, 10

moChef_lp:
            MOV    al, j
            MOV    ah, 2
            MUL    ah

            MOV    Vrow, 5
            ADD    Vrow, al
            CALL   moveCursor

            MOV    al, j
            MOV    ah, 0
            MOV    si, ax
            MOV    bl, i
            CMP    bl, fL_chef[si]
            JNE    moChef_lp_con0
            CALL   pntBuf
            INC    j
            JMP    moChef_lp_con1
moChef_lp_con0:
            CALL   skipBuf
moChef_lp_con1:
            INC    i

            CMP    j, 9
            JL     moChef_lp_con
            MOV    j, 0
            MOV    Vcol, 50

moChef_lp_con:
            CMP    buf[di], '#'
            JNE    moChef_lp

            MOV    Vam, 4
            MOV    Vam2, 0
            CALL   makeArrow2

            MOV    ah, 3Eh
            INT    21h


            CALL   inf  ; temp
            RET

moAll:
            MOV    ah, 3Dh
            MOV    dx, offset foodFile
            MOV    al, 00h
            INT    21h

            MOV    bx, ax

            MOV    ah, 3Fh
            MOV    cx, 1000
            MOV    dx, offset buf
            INT    21h

            MOV    di, 0
            MOV    i, 0
            MOV    Vcol, 10

moAll_lp:
            MOV    al, i
            MOV    ah, 2
            MUL    ah

            MOV    Vrow, 5
            ADD    Vrow, al
            CALL   moveCursor

            CALL   pntBuf

            INC    i

            CMP    i, 9
            JL     moAll_lp_con
            MOV    i, 0
            MOV    Vcol, 50

moAll_lp_con:
            CMP    buf[di], '#'
            JNE    moAll_lp

            MOV    Vam, 9
            MOV    Vam2, 6
            CALL   makeArrow2

            MOV    ah, 3Eh
            INT    21h


            CALL   inf  ; temp
            RET

mGame:
            ; TODO: paste game from LOUIS
            RET

mCall:
            ; TODO: pop-up yes or no
            RET

mBill:
            ; TODO: bill calculation
            RET

inf:
            NOP
            JMP    inf

            RET

changeScr:
            MOV    Vrow, 02h
            MOV    Vcol, 00h

            MOV    cx, 78
changeScr_lp1:
            PUSH   cx

            INC    Vcol
            MOV    Vrow, 02h

            MOV    cx, 20
            ; MOV    cx, 22
changeScr_lp2:
            PUSH   cx

            INC    Vrow
            CALL   moveCursor

            MOV    ah, 09h
            MOV    al, 0
            MOV    bh, 00h
            MOV    bl, 30h
            MOV    cx, 01h
            INT    10h

            POP    cx
            LOOP   changeScr_lp2

            MOV    ah, 86h
            MOV    cx, 00h
            MOV    dx, 5000h
            INT    15h

            POP    cx
            LOOP   changeScr_lp1

            MOV    Vrow, 02h
            MOV    Vcol, 00h

            MOV    cx, 78
changeScr_lp3:
            PUSH   cx

            INC    Vcol
            MOV    Vrow, 02h

            MOV    cx, 20
            ; MOV    cx, 22
changeScr_lp4:
            PUSH   cx

            INC    Vrow
            CALL   moveCursor

            MOV    ah, 09h
            MOV    al, 0
            MOV    bh, 00h
            MOV    bl, 07h
            MOV    cx, 01h
            INT    10h

            POP    cx
            LOOP   changeScr_lp4

            MOV    ah, 86h
            MOV    cx, 00h
            MOV    dx, 5000h
            INT    15h

            POP    cx
            LOOP   changeScr_lp3

            RET

pntMenu:
            MOV    Vrow, 7
            MOV    Vcol, 30
            CALL   moveCursor

            MOV    dx, offset mS_order
            CALL   pntTxt

            ADD    Vrow, 2
            CALL   moveCursor

            MOV    dx, offset mS_game
            CALL   pntTxt

            ADD    Vrow, 2
            CALL   moveCursor

            MOV    dx, offset mS_call
            CALL   pntTxt

            ADD    Vrow, 2
            CALL   moveCursor

            MOV    dx, offset mS_bill
            CALL   pntTxt

            RET

pntFoodType:
            MOV    Vrow, 7
            MOV    Vcol, 0
            CALL   moveCursor

            MOV    dx, offset foodType
            CALL   pntTxt

            ADD    Vrow, 8
            MOV    Vcol, 30
            CALL   moveCursor

            MOV    dx, offset back
            CALL   pntTxt

            RET

; -- makeArrow2 --
; input:
; Vam - amount of row
; Vam2 - amount of row2
;
; output:
; m - option selected
; ---------
makeArrow2:
            MOV    m, 0
            MOV    n, 0

makeArrow2_rpt:
            MOV    Vrow, 5
            MOV    Vcol, 8
            CALL   moveCursor

            MOV    ch, 00h
            MOV    cl, Vam

makeArrow2_lp:
            MOV    ah, 02h
            MOV    dl, 00h
            INT    21h

            ADD    Vrow, 2
            CALL   moveCursor

            LOOP   makeArrow2_lp

            MOV    Vrow, 5
            MOV    vcol, 48
            CALL   moveCursor

            CMP    Vam2, 0
            JE     makeArrow2_con0
            MOV    ch, 00h
            MOV    cl, Vam2

makeArrow2_lp2:
            MOV    ah, 02h
            MOV    dl, 00h
            INT    21h

            ADD    Vrow, 2
            CALL   moveCursor

            LOOP   makeArrow2_lp2
makeArrow2_con0:
            MOV    Vcol, 8
            CMP    n, 0
            JE     makeArrow2_con
            ADD    Vcol, 40

makeArrow2_con:
            MOV    al, m
            MOV    ah, 2
            MUL    ah
            MOV    Vrow, al
            ADD    Vrow, 5
            CALL   moveCursor

            MOV    ah, 02h                  ; print '>' to selected menu
            MOV    dl, 16
            INT    21h

makeArrow2_inflp:
            MOV    ah, 01h                  ; wait for key pressed
            INT    16h
            JZ     makeArrow2_inflp

            MOV    ah, 00h                  ; get key from buffer
            INT    16h

makeArrow2_checkup:
            CMP    ah, 72                   ; arrow up
            JNE    makeArrow2_checkdown

            CMP    m, 0
            JE     makeArrow2_inflp
            DEC    m                        ; decrease menu
            JMP    makeArrow2_rpt

makeArrow2_checkdown:
            CMP    ah, 80                   ; arrow down
            JNE    makeArrow2_checkleft

            MOV    cl, Vam
            CMP    n, 0
            JE     makeArrow2_con1
            MOV    cl, Vam2
makeArrow2_con1:
            DEC    cl
            CMP    m, cl
            JE     makeArrow2_inflp
            INC    m                        ; increase menu
            JMP    makeArrow2_rpt

makeArrow2_checkleft:
            CMP    ah, 75                   ; arrow left
            JNE    makeArrow2_checkright

            CMP    n, 0
            JE     makeArrow2_inflp
            DEC    n                        ; shift left menu
            JMP    makeArrow2_rpt

makeArrow2_checkright:
            CMP    ah, 77                   ; arrow right
            JNE    makeArrow2_checkenter

            CMP    n, 1
            JE     makeArrow2_inflp

            MOV    cl, Vam2
            CMP    m, cl
            JGE    makeArrow2_inflp
            INC    n                        ; shift right menu
            JMP    makeArrow2_rpt

makeArrow2_checkenter:
            CMP    al, 13                   ; carriage return
            JNE    makeArrow2_inflp                    ; if no key pressed then infinite loop

            CMP    n, 0
            JE     makeArrow_con2
            ADD    m, 9

makeArrow_con2:
            RET

; -- makeArrow --
; input:
; Vam - amount of row
;
; output:
; m - option selected
; ---------
makeArrow:
            MOV    m, 0

makeArrow_rpt:
            MOV    Vrow, 7
            MOV    Vcol, 28
            CALL   moveCursor

            MOV    ch, 00h
            MOV    cl, Vam

makeArrow_lp:
            MOV    ah, 02h
            MOV    dl, 00h
            INT    21h

            ADD    Vrow, 2
            CALL   moveCursor

            LOOP   makeArrow_lp

            MOV    al, m
            MOV    ah, 2
            MUL    ah
            MOV    Vrow, al
            ADD    Vrow, 7
            CALL   moveCursor

            MOV    ah, 02h                  ; print '>' to selected menu
            MOV    dl, 16
            INT    21h

makeArrow_inflp:
            MOV    ah, 01h                  ; wait for key pressed
            INT    16h
            JZ     makeArrow_inflp

            MOV    ah, 00h                  ; get key from buffer
            INT    16h

makeArrow_checkup:
            CMP    ah, 72                   ; arrow up
            JNE    makeArrow_checkdown

            CMP    m, 0
            JE     makeArrow_inflp
            DEC    m                        ; decrease menu
            JMP    makeArrow_rpt

makeArrow_checkdown:
            CMP    ah, 80                   ; arrow down
            JNE    makeArrow_checkenter

            MOV    cl, Vam
            DEC    cl
            CMP    m, cl
            JE     makeArrow_inflp
            INC    m                        ; increase menu
            JMP    makeArrow_rpt

makeArrow_checkenter:
            CMP    al, 13                   ; carriage return
            JNE    makeArrow_inflp                    ; if no key pressed then infinite loop

            RET

; -- pntTxt --
; input:
; dl,dx - offset text to print

; output:
; none
; ---------
pntTxt:
            MOV    ah, 09h
            INT    21h

            RET

; -- pntBuf --
; input:
; di - 0 [one time]
; buf - buffer text to print

; output:
; di - next string
; ---------
pntBuf:
            MOV    ah, 02h
pntBuf_rpt:
            MOV    dl, buf[di]
            INT    21h

            ; MOV    cx, 01h
            ; CALL   dlay

            INC    di
            CMP    buf[di], '$'
            JNE    pntBuf_rpt

            ADD    di, 2

            RET
pntBuf2:
            MOV    ah, 02h
pntBuf2_rpt:
            MOV    dl, buf2[di]
            INT    21h

            ; MOV    cx, 01h
            ; CALL   dlay

            INC    di
            CMP    buf2[di], '$'
            JNE    pntBuf2_rpt

            ADD    di, 2

            RET

; -- skipBuf --
; input:
; di - 0 [one time]
; buf - buffer text to print

; output:
; di - next string
; ---------
skipBuf:
            INC    di
            CMP    buf[di], '$'
            JNE    skipBuf

            ADD    di, 2

            RET
skipBuf2:
            INC    di
            CMP    buf2[di], '$'
            JNE    skipBuf2

            ADD    di, 2

            RET

; -- moveCursor --
; input:
; Vrow - row to move
; Vcol - col to move
;
; output:
; none
; ---------
moveCursor:
            ; PUSH   ax
            ; PUSH   bx

            MOV    ah, 02h
            MOV    dh, Vrow
            MOV    dl, Vcol
            MOV    bh, 00h
            INT    10h

            ; POP    bx
            ; POP    ax

            RET

moveCursor2:
            ; PUSH   ax
            ; PUSH   bx

            MOV    ah, 02h
            MOV    dh, Vrow
            MOV    dl, Vcol
            MOV    bh, 01h
            INT    10h

            ; POP    bx
            ; POP    ax

            RET

; -- pntNum --
; input:
; Vnum - input of number to print (1-2 digits)
;
; output:
; none
; ---------
pntNum:
            MOV    ax, Vnum
            MOV    cl, 10
            DIV    cl

            PUSH   ax

            CMP    al, 0
            JE     pntNum_skipZero

            ADD    al, '0'
            MOV    ah, 0Ah
            MOV    bh, 00h
            MOV    cx, 01h
            INT    10h

            MOV    ah, 03h
            MOV    bh, 00h
            INT    10h

            ADD    dl, 01h
            MOV    ah, 02h
            MOV    bh, 00h
            INT    10h

pntNum_skipZero:
            POP    ax

            MOV    al, ah
            ADD    al, '0'
            MOV    ah, 0Ah
            MOV    bh, 00h
            MOV    cx, 01h
            INT    10h

            RET

; -- pntNum --
; input:
; cx - amount of delay
;
; output:
; none
; ---------
dlay:
            PUSH   ax
            PUSH   dx

            MOV    ah, 86h
            ; MOV    cx, 00h
            ; MOV    dx, 5000h
            MOV    dx, 00h
            INT    15h

            POP    dx
            POP    ax

            RET



            END    main
