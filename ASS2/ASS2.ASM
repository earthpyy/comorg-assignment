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

        RET
        END    main
