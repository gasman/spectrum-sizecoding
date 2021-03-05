; Given an address in screen memory in DE, return the address of the next pixel line down

upde
            inc d
            ld a,d
            and 7
            ret nz
            ld a,e
            add a,32
            ld e,a
            ret c
            ld a,d
            sub 8
            ld d,a
            ret
