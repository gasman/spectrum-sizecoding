            org 0x8000

CALC_DELETE        equ 0x02
CALC_MULTIPLY      equ 0x04
CALC_ADDITION      equ 0x0f
CALC_SIN           equ 0x1f
CALC_INT           equ 0x27
CALC_DUPLICATE     equ 0x31
CALC_CONST         equ 0x34
CALC_STK_ZERO      equ 0xa0
CALC_ST_MEM_0      equ 0xc0
CALC_END_CALC      equ 0x38

sine    equ 0xf000

            xor a
            out (254),a

            rst 0x28
            ; put t (initially 0) on calculator stack
            db CALC_STK_ZERO
            db CALC_END_CALC

            ld hl,sine
sine_loop
            push hl

            rst 0x28
            ; increment t by pi/64
            db CALC_CONST, 0x2b, 0x49    ;const pi/128 (ish)
            db CALC_ADDITION
            ; calculate int(sin(t) * 113)
            db CALC_DUPLICATE
            db CALC_SIN
            db CALC_CONST, 0x37, 0x34    ; const 90
            db CALC_MULTIPLY
            db CALC_INT
            ; place result in calculator memory area for retrieval
            db CALC_ST_MEM_0
            db CALC_DELETE
            db CALC_END_CALC
            ld a,(iy+0x5a)    ; third byte of calculator memory 0

            pop hl
            ld (hl),a
            inc l
            jr nz,sine_loop


            ld hl,0x4000
            ld (hl),0x55
            ld de,0x4001
            ld bc,0x0100
            ldir
            ld (hl),0xaa
            ld bc,0x0100
            ldir
            ld hl,0x4000
            ld de,0x4200
            ld bc,0x1600
            ldir

            ld hl,sine
frame_loop
            halt
            push hl
            ld de,0x5800
            ld b,24
row_loop
            ld c,32
char_loop
            ld a,c
            add a,(hl)
            xor b
            ld (de),a
            inc de
            dec c
            jp nz,char_loop
            inc l
            djnz row_loop
            pop hl
            inc l
            jr frame_loop
