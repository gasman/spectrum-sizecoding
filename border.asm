; the simplest possible program that does something: turn the border red

            org 0x8000

            ld a,2
            out (254),a
            ret
