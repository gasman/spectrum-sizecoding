            org 0x8000

; Opcodes for the floating-point calculator routine
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

sine        equ 0xf000  ; write our sine table here

            ; set border to black
            xor a
            out (254),a

            ; generate sine table
            rst 0x28  ; enter floating point calculator
            db CALC_STK_ZERO  ; put t (initially 0) on calculator stack
            db CALC_END_CALC

            ld hl,sine
sine_loop
            push hl

            rst 0x28  ; enter floating point calculator
            ; increment t by pi/64
            db CALC_CONST, 0x2b, 0x49    ;const pi/128 (ish)
            db CALC_ADDITION
            ; calculate int(sin(t) * 90)
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
            ld (hl),a  ; write result to sine table
            inc l  ; advance and loop until l wraps round to 0
            jr nz,sine_loop

            ; draw checkerboard background
            ld hl,0x4000  ; start of screen memory
            ld (hl),0x55  ; 01010101, first half of checkerboard pattern
            ld de,0x4001
            ld bc,0x0100  ; repeat 0x0100 times, taking us to the second pixel row
            ldir
            ld (hl),0xaa  ; 10101010, second half of checkerboard pattern
            ld bc,0x0100
            ldir
            ld hl,0x4000
            ld de,0x4200
            ld bc,0x1600  ; copy to the remaining 6 rows (0x0600 bytes) of the top block,
            ldir          ; and the remaining two blocks (2 * 0x0800 bytes)

            ; main loop - draw xor pattern
            ld hl,sine
frame_loop
            halt
            push hl       ; store initial sine table position
            ld de,0x5800  ; start of attribute memory
            ld b,24       ; repeat for 24 character rows
row_loop
            ld c,32       ; repeat for 32 character columns
char_loop
            ld a,c
            add a,(hl)    ; add sine table displacement to x coordinate
            xor b         ; xor with y coordinate
            ld (de),a     ; write back to attribute memory
            inc de        ; advance to next character cell
            dec c
            jp nz,char_loop
            inc l         ; advance sine table position for next row
            djnz row_loop
            pop hl        ; recall initial sine table position
            inc l         ; advance sine table position for next frame
            jr frame_loop
