SECTION "lcd", ROM0

; Mod: A
lcdwait:
    ld a, [$FF44]
    cp 145
    jp nz, lcdwait
ret

; Mod: A
lcdon:
    ld a, %10010001
    ld [rLCDC], a
ret

; Mod: A
lcdoff:
    ld a, 0
    ld [rLCDC], a
ret
