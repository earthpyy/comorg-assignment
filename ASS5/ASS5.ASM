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

mS_order    DB     'Order Now!$', 0
mS_status   DB     'Status/Cart$', 0
mS_game     DB     'Games$', 0
mS_call     DB     'Call waiter/waitress$', 0
mS_bill     DB     'Bill$', 0

back        DB     'Press `b` to go back..$', 0
con_order   DB     'Are you sure you want to order?$', 0
con_remove  DB     'Are you sure you want to remove?$', 0
con_yesno   DB     'YES :)               NO :($', 0
cart_txt    DB     'Cart x   | THB $', 0
bf_price    DB     ' (THB $', 0
at_price    DB     ')$', 0
st_none     DB     'You have not order anything yet!$', 0
st_sub      DB     '     Subtotal:   THB $', 0
st_vat      DB     '      VAT(7%):   THB $', 0
st_svch     DB     ' Service(10%):   THB $', 0
st_total    DB     '        Total:   THB $', 0

foodType    DB     219, '                             Chef Recommended!                                ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             Popular Dishes                                   ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             New Items                                        ', 219
            DB     219, '                                                                              ', 219
            DB     219, '                             View All                                         ', 219, '$', 0

fL_chef     DB     1, 2, 6, 8, -1

fL_sel      DB     30 DUP(-1)
; fL_sel      DB     1, 3, 2
fL_i        DW     0
fL_j        DW     0
fL_price    DW     0

Vrow        DB     ?
Vcol        DB     ?
Vam         DB     ?
Vam2        DB     ?
i           DB     ?
j           DB     ?
k           DB     ?
m           DB     ?
n           DB     ?

price_tmp   DW     ?
Vnum        DW     ?

foodFile    DB     "X:\PROJ\COMORG~1\ASS5\TXT\FOOD2.TXT", 0
buf         DB     ?

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

            CALL   pntCart

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

            ; CALL   pntCart

            MOV    Vrow, 10
            MOV    Vcol, 24
            CALL   moveCursor2

            MOV    dx, offset con_order
            CALL   pntTxt

            MOV    Vrow, 12
            MOV    Vcol, 26
            CALL   moveCursor2

            MOV    dx, offset con_yesno
            CALL   pntTxt

            ; MOV    ah, 05h
            ; MOV    al, 00h
            ; INT    10h

page3:
            MOV    ah, 05h
            MOV    al, 02h
            INT    10h

            MOV    dx, offset pFrame
            CALL   pntTxt

            MOV    Vrow, 01h
            MOV    Vcol, 02h
            CALL   moveCursor3

            MOV    dx, offset storeName
            CALL   pntTxt

            ; CALL   pntCart

            MOV    Vrow, 10
            MOV    Vcol, 23
            CALL   moveCursor3

            MOV    dx, offset con_remove
            CALL   pntTxt

            MOV    Vrow, 12
            MOV    Vcol, 26
            CALL   moveCursor3

            MOV    dx, offset con_yesno
            CALL   pntTxt

            MOV    ah, 05h
            MOV    al, 00h
            INT    10h

startp:
            CALL   changeScr
            CALL   pntMenu

            MOV    Vrow, 7
            MOV    Vam, 5
            CALL   makeArrow

            ; menu selected
            CMP    m, 3
            JNE    startp_0
            CALL   mCall
            JMP    startp
            startp_0:
                        ; CALL   changeScr

                        CMP    m, 0
                        JNE    startp_1
                        CALL   mOrder
                        JMP    startp
            startp_1:
                        CMP    m, 1
                        JNE    startp_2
                        CALL   mStatus
                        JMP    startp
            startp_2:
                        CMP    m, 2
                        JNE    startp_3
                        CALL   mGame
                        JMP    startp
            startp_3:
                        CALL   mBill
                        JMP    startp

            RET

mOrder:
            CALL   changeScr
            CALL   pntFoodType

            MOV    Vrow, 7
            MOV    Vam, 4
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
            CMP    m, 3
            JNE    mOrder_3
            CALL   moAll
            JMP    mOrder
mOrder_3:
            RET

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
                        CALL   pntBufCost
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

                        MOV    ah, 3Eh
                        INT    21h

                        MOV    Vam, 4
                        MOV    Vam2, 0
                        CALL   makeArrow2

                        CMP    m, -1
                        JNE    moChef_confirm
                        JMP    moChef_out

            moChef_confirm:
                        MOV    al, 01h
                        CALL   showConfirm

                        CMP    n, 0
                        JE     moChef_out

                        MOV    di, fL_j
                        MOV    ah, 00h
                        MOV    al, m
                        MOV    si, ax
                        MOV    al, fL_chef[si]
                        MOV    fL_sel[di], al

                        MOV    j, al
                        CALL   getCost
                        MOV    ax, price_tmp
                        ADD    fL_price, ax

                        INC    fL_i
                        INC    fL_j

            moChef_out:
                        CALL   clearScr
                        ; JMP    moChef
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

                        CALL   pntBufCost

                        INC    i

                        CMP    i, 9
                        JL     moAll_lp_con
                        MOV    i, 0
                        MOV    Vcol, 50

            moAll_lp_con:
                        CMP    buf[di], '#'
                        JNE    moAll_lp

                        MOV    ah, 3Eh
                        INT    21h

                        MOV    Vam, 9
                        MOV    Vam2, 6
                        CALL   makeArrow2


                        CALL   inf  ; temp
                        RET

mStatus:
            CALL   changeScr

            MOV    Vrow, 5
            MOV    Vcol, 50
            CALL   moveCursor

            MOV    dx, offset st_sub
            CALL   pntTxt

            MOV    dx, fL_price
            MOV    Vnum, dx
            CALL   pntNum

            MOV    Vrow, 6
            MOV    Vcol, 50
            CALL   moveCursor

            MOV    dx, offset st_vat
            CALL   pntTxt

            MOV    ax, fL_price
            MOV    dx, 7
            MUL    dx

            MOV    dx, 00h
            MOV    cx, 100
            DIV    cx

            CMP    dx, 0
            JE     mStatus_rmd
            INC    ax

            mStatus_rmd:
                        MOV    price_tmp, ax
                        MOV    Vnum, ax
                        CALL   pntNum

                        MOV    Vrow, 7
                        MOV    Vcol, 50
                        CALL   moveCursor

                        MOV    dx, offset st_svch
                        CALL   pntTxt

                        MOV    ax, fL_price
                        MOV    dx, 00h
                        MOV    cx, 10
                        DIV    cx

                        CMP    dx, 0
                        JE     mStatus_rmd1
                        INC    ax

            mStatus_rmd1:
                        MOV    Vnum, ax
                        CALL   pntNum

                        MOV    Vrow, 9
                        MOV    Vcol, 50
                        CALL   moveCursor

                        MOV    dx, offset st_total
                        CALL   pntTxt

                        MOV    dx, fL_price
                        ADD    dx, Vnum
                        ADD    dx, price_tmp
                        MOV    Vnum, dx
                        CALL   pntNum

            CMP    fL_i, 0
            JNE    mStatus_start

            MOV    Vrow, 5
            MOV    Vcol, 10
            CALL   moveCursor

            MOV    dx, offset st_none
            CALL   pntTxt

            CALL   waitForBack
            JMP    mStatus_out

            mStatus_start:
                        MOV    Vrow, 3
                        MOV    Vcol, 10
                        MOV    k, 0
                        MOV    cx, fL_j
            mStatus_lp:
                        PUSH   cx

                        ADD    Vrow, 2
                        CALL   moveCursor

                        MOV    al, k
                        MOV    ah, 00h
                        MOV    di, ax
                        MOV    dl, fL_sel[di]
                        MOV    j, dl

                        CMP    j, -1
                        JE     mStatus_skip
                        CALL   getMenu
                        JMP    mStatus_con
            mStatus_skip:
                        SUB    Vrow, 2
            mStatus_con:
                        INC    k
                        POP    cx
                        LOOP   mStatus_lp

                        MOV    ax, fL_i
                        MOV    Vam, al
                        MOV    Vam2, 0
                        CALL   makeArrow2

            mStatus_confirm:
                        MOV    al, 02h
                        CALL   showConfirm

                        CMP    n, 0
                        JE     mStatus_out

                        MOV    dl, m
                        MOV    dh, 00h
                        MOV    si, dx
                        MOV    fL_sel[si], -1

                        DEC    fL_i

            mStatus_out:
                        CALL   clearScr
                        ; JMP    mStatus
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

waitForBack:
            MOV    ah, 01h
            INT    16h
            JZ     waitForBack

            MOV    ah, 00h
            INT    16h
            CMP    al, 'b'
            JNE    waitForBack

            RET

clearScr:
            CALL   pntCart

            MOV    Vrow, 02h
            MOV    Vcol, 00h

            MOV    cx, 78
            clearScr_lp1:
                        PUSH   cx

                        INC    Vcol
                        MOV    Vrow, 02h

                        MOV    cx, 20
                        ; MOV    cx, 22
            clearScr_lp2:
                        PUSH   cx

                        INC    Vrow
                        CALL   moveCursor

                        MOV    ah, 09h
                        MOV    al, 0
                        MOV    bh, 00h
                        MOV    bl, 00h
                        MOV    cx, 01h
                        INT    10h

                        POP    cx
                        LOOP   clearScr_lp2

                        ; MOV    ah, 86h
                        ; MOV    cx, 00h
                        ; MOV    dx, 5000h
                        ; INT    15h

                        POP    cx
                        LOOP   clearScr_lp1

            RET

changeScr:
            CALL   pntCart

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

                        ; MOV    ah, 86h
                        ; MOV    cx, 00h
                        ; MOV    dx, 5000h
                        ; INT    15h

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

                        ; MOV    ah, 86h
                        ; MOV    cx, 00h
                        ; MOV    dx, 5000h
                        ; INT    15h

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

            MOV    dx, offset mS_status
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

            ; ADD    Vrow, 8
            ; MOV    Vcol, 30
            ; CALL   moveCursor
            ;
            ; MOV    dx, offset back
            ; CALL   pntTxt

            RET

pntCart:
            PUSH   ax

            MOV    Vrow, 01h
            MOV    Vcol, 59
            CALL   moveCursor

            MOV    dx, offset cart_txt
            CALL   pntTxt

            MOV    Vrow, 01h
            MOV    Vcol, 65
            CALL   moveCursor

            MOV    ax, fL_i
            MOV    Vnum, ax
            CALL   pntNum

            MOV    Vrow, 01h
            MOV    Vcol, 74
            CALL   moveCursor

            MOV    ax, fL_price
            MOV    Vnum, ax
            CALL   pntNum

            POP    ax

            RET

; -- showConfirm --
; input:
; al - page
;
; output:
; n - 0->no, 1->yes
; ---------
showConfirm:
            MOV    ah, 05h
            ; MOV    al, 01h
            INT    10h

            showConfirm_inflp:
                        MOV    ah, 01h                  ; wait for key pressed
                        INT    16h
                        JZ     showConfirm_inflp

                        MOV    ah, 00h                  ; get key from buffer
                        INT    16h

            showConfirm_checkno:
                        CMP    al, 'n'
                        JNE    showConfirm_checkyes
                        MOV    n, 0
                        JMP    showConfirm_out

            showConfirm_checkyes:
                        CMP    al, 'y'
                        JNE    showConfirm_inflp
                        MOV    n, 1
                        JMP    showConfirm_out

            showConfirm_out:
                        MOV    ah, 05h
                        MOV    al, 00h
                        INT    10h

            RET


; -- getMenu --
; input:
; j - index
;
; output:
; none
; ---------
getMenu:
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

            getMenu_lp:
                        MOV    al, j
                        CMP    i, al
                        JNE    getMenu_lp_con0
                        CALL   pntBuf

                        MOV    ah, 3Eh
                        INT    21h

                        JMP    getMenu_out

            getMenu_lp_con0:
                        CALL   skipBuf
                        INC    i

                        CMP    buf[di], '#'
                        JNE    getMenu_lp
            getMenu_out:
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
                        JNE    makeArrow2_checkback

                        CMP    n, 1
                        JE     makeArrow2_inflp

                        MOV    cl, Vam2
                        CMP    m, cl
                        JGE    makeArrow2_inflp
                        INC    n                        ; shift right menu
                        JMP    makeArrow2_rpt

            makeArrow2_checkback:
                        CMP    al, 'b'                   ; b
                        JNE    makeArrow2_checkenter

                        MOV    m, -1
                        JMP    makeArrow2_con2

            makeArrow2_checkenter:
                        CMP    al, 13                   ; carriage return
                        JNE    makeArrow2_inflp                    ; if no key pressed then infinite loop

                        CMP    n, 0
                        JE     makeArrow2_con2
                        ADD    m, 9

            makeArrow2_con2:
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
                        JNE    makeArrow_checkback

                        MOV    cl, Vam
                        DEC    cl
                        CMP    m, cl
                        JE     makeArrow_inflp
                        INC    m                        ; increase menu
                        JMP    makeArrow_rpt

            makeArrow_checkback:
                        CMP    al, 'b'                   ; b
                        JNE    makeArrow_checkenter

                        MOV    m, -1
                        RET

            makeArrow_checkenter:
                        CMP    al, 13                   ; carriage return
                        JNE    makeArrow_inflp                    ; if no key pressed then infinite loop

                        RET

; -- pntTxt --
; input:
; dl,dx - offset text to print
;
; output:
; none
; ---------
pntTxt:
            PUSH   ax

            MOV    ah, 09h
            INT    21h

            POP    ax

            RET

; -- pntBuf --
; input:
; di - 0 [one time]
; buf - buffer text to print
;
; output:
; di - next string
; ---------
pntBuf:
            MOV    ah, 02h
            pntBuf_rpt:
                        MOV    dl, buf[di]
                        INT    21h

                        INC    di
                        CMP    buf[di], '$'
                        JNE    pntBuf_rpt

                        ADD    di, 9

            RET

; -- pntBufCost --
; input:
; di - 0 [one time]
; buf - buffer text to print
;
; output:
; di - next string
; ---------
pntBufCost:
            MOV    ah, 02h
            pntBufCost_rpt:
                        MOV    dl, buf[di]
                        INT    21h

                        INC    di
                        CMP    buf[di], '$'
                        JNE    pntBufCost_rpt

            MOV    dx, offset bf_price
            CALL   pntTxt

            pntBufCost_lp:
                        INC    di
                        CMP    buf[di], '0'
                        JE     pntBufCost_lp

                        MOV    dl, buf[di]
            pntBufCost_lp1:
                        INT    21h
                        INC    di
                        MOV    dl, buf[di]
                        CMP    dl, '@'
                        JNE    pntBufCost_lp1

            MOV    dx, offset at_price
            CALL   pntTxt
            ADD    di, 5

            RET

; -- skipBuf --
; input:
; di - 0 [one time]
; buf - buffer text to print
;
; output:
; di - next string
; ---------
skipBuf:
            INC    di
            CMP    buf[di], '$'
            JNE    skipBuf

            ADD    di, 9

            RET

; -- getCost --
; input:
; j - index
;
; output:
; price_tmp - price of index
; ---------
getCost:
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

            getCost_lp:
                        MOV    al, j
                        CMP    i, al
                        JNE    getCost_lp_con

            getCost_rpt:
                        INC    di
                        CMP    buf[di], '$'
                        JNE    getCost_rpt

                        INC    di
                        MOV    dl, buf[di]
                        MOV    price_tmp, 0
            getCost_lp1:
                        MOV    ax, price_tmp
                        MOV    cx, 10
                        PUSH   dx
                        MUL    cx
                        POP    dx
                        MOV    price_tmp, ax

                        SUB    dl, '0'
                        MOV    dh, 00h
                        ADD    price_tmp, dx

                        INC    di
                        MOV    dl, buf[di]
                        CMP    dl, '@'
                        JNE    getCost_lp1

                        MOV    ah, 3Eh
                        INT    21h

                        JMP    getCost_out

            getCost_lp_con:
                        CALL   skipBuf
                        INC    i

                        CMP    buf[di], '#'
                        JNE    getCost_lp
            getCost_out:
                        RET


            ; MOV    ah, 02h
            ; getCost_rpt:
            ;             MOV    dl, buf[di]
            ;             INT    21h
            ;
            ;             INC    di
            ;             CMP    buf[di], '$'
            ;             JNE    getCost_rpt
            ;
            ;             INC    di
            ;             MOV    dl, buf[di]
            ;             MOV    price_tmp, 0
            ; getCost_lp:
            ;             MOV    ax, price_tmp
            ;             MOV    cx, 10
            ;             MUL    cx
            ;             MOV    price_tmp, ax
            ;
            ;             SUB    dl, '0'
            ;             ADD    price_tmp, dl
            ;
            ;             INC    di
            ;             MOV    dl, buf[di]
            ;             CMP    dl, '@'
            ;             JNE    getCost_lp1
            ;
            ;             ADD    di, 9

            ; RET

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

moveCursor3:
            ; PUSH   ax
            ; PUSH   bx

            MOV    ah, 02h
            MOV    dh, Vrow
            MOV    dl, Vcol
            MOV    bh, 02h
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
; pntNum:
;             MOV    ax, Vnum
;             MOV    cl, 10
;             DIV    cl
;
;             PUSH   ax
;
;             CMP    al, 0
;             JE     pntNum_skipZero
;
;             ADD    al, '0'
;             MOV    ah, 0Ah
;             MOV    bh, 00h
;             MOV    cx, 01h
;             INT    10h
;
;             MOV    ah, 03h
;             MOV    bh, 00h
;             INT    10h
;
;             ADD    dl, 01h
;             MOV    ah, 02h
;             MOV    bh, 00h
;             INT    10h
;
;             pntNum_skipZero:
;                         POP    ax
;
;                         MOV    al, ah
;                         ADD    al, '0'
;                         MOV    ah, 0Ah
;                         MOV    bh, 00h
;                         MOV    cx, 01h
;                         INT    10h
;
;             RET

pntNum:
            MOV    i, 0

            MOV    dx, 00h
            MOV    ax, Vnum
            MOV    cx, 1000
            DIV    cx
            MOV    cx, dx

            CMP    ax, 0
            JE     pntNum_1

            INC    i

            ADD    ax, '0'
            MOV    ah, 02h
            MOV    dl, al
            INT    21h

            pntNum_1:
                        MOV    dx, 00h
                        MOV    ax, cx
                        MOV    cx, 100
                        DIV    cx
                        MOV    cx, dx

                        CMP    ax, 0
                        JNE    pntNum_t2
                        CMP    i, 0
                        JE     pntNum_2
            pntNum_t2:
                        INC    i

                        ADD    ax, '0'
                        MOV    ah, 02h
                        MOV    dl, al
                        INT    21h
            pntNum_2:
                        MOV    dx, 00h
                        MOV    ax, cx
                        MOV    cx, 10
                        DIV    cx
                        MOV    cx, dx

                        CMP    ax, 0
                        JNE    pntNum_t3
                        CMP    i, 0
                        JE     pntNum_3
            pntNum_t3:

                        ADD    ax, '0'
                        MOV    ah, 02h
                        MOV    dl, al
                        INT    21h
            pntNum_3:
                        MOV    dx, 00h
                        MOV    ax, cx
                        MOV    cx, 10
                        DIV    cx

                        ADD    dx, '0'
                        MOV    ah, 02h
                        INT    21h

            RET

; -- dlay --
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
