; slowly fill the video memory, to demonstrate the screen layout

            org 0x8000

            ld hl,0x4000
loop
            ld (hl),l
            halt
            inc hl
            jr loop
