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

foodType    DB     219, '                             Chef Recommended!                                ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             Popular Dishes                                   ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             New Items                                        ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             View All                                         ', 219, '$', 0

foodList    DB     'Spicy Beef Nacho$', 0
            DB     'Double Cheeze Pizza$', 0
            DB     'Chicken Kabab$', 0

foodListLenA DB    3
foodListLen DB     18, 21, 15

fL_chefA    DB     2
fL_chef     DB     0, 2

Vrow        DB     ?
Vcol        DB     ?
Vam         DB     ?
i           DB     ?
j           DB     ?
m           DB     ?

Vnum        DW     ?

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

startp:
            CALL   pntMenu

            MOV    Vrow, 7
            MOV    Vam, 4
            CALL   makeArrow

            ; menu selected
            CMP    m, 2
            JE     mCall

            CALL   changeScr

            CMP    m, 0
            JE     mOrder

            CMP    m, 1
            JE     mGame

            JMP    mBill

mOrder:
            CALL   pntFoodType

            MOV    Vrow, 7
            MOV    Vam, 5
            CALL   makeArrow

            ; food type selected
            CALL   changeScr

            ; CMP    m, 0
            ; JE     moChef
            ;
            ; CMP    m, 1
            ; JE     moPop
            ;
            ; CMP    m, 2
            ; JE     moNew
            ;
            CMP    m, 3
            JE     moAll

            JMP    startp

moAll:
            MOV    Vrow, 7
            MOV    Vcol, 30
            CALL   moveCursor

            MOV    dx, offset foodList
            CALL   pntTxt


            CALL   inf

mGame:
            ; TODO: paste game from LOUIS
            JMP    startp

mCall:
            ; TODO: pop-up yes or no
            JMP    startp

mBill:
            ; TODO: bill calculation
            JMP    startp

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

; -- makeArrow --
; input:
; Vrow - start row
; Vam - amount of row
;
; output:
; m - option selected
; ---------
makeArrow:
            MOV    m, 0
            MOV    bl, Vrow
            MOV    j, bl

makeArrow_rpt:
            MOV    bl, j
            MOV    Vrow, bl
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
            MOV    bl, al
            ADD    bl, j

            MOV    Vrow, bl
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
; dx - text to print

; output:
; none
; ---------
pntTxt:
            MOV    ah, 09h
            ; MOV    dx, offset Vtxt
            INT    21h

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


            END    main
