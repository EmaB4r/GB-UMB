SECTION "stdlib", ROM0

; Mod: A
; de: dest ptr
; hl: src ptr
; bc: dest len  
memcpy:
    push af
    _memcpy_loop:
        ld a, [hli]     ; load byte from src ptr and inc srcptr
        ld [de], a      ; store the value to dest
        inc de
        dec bc          ; dec counter
        ld a, b         ; check if bc == 0
        or c
    jr nz, _memcpy_loop ; jump if bc!=0
    pop af
ret

; Mod: A
; de: dest ptr
; hl: src ptr
; bc: dest len  
Vramcpy:
    push af
    call lcdwait
    call lcdoff
    _Vramcpy_loop:
        ld a, [hl]   ; load byte from src ptr and inc srcptr
        inc hl
        ld [de], a   ; store the value to dest
        inc de
        ld [de], a   ; store the value to dest
        inc de
        dec bc       ; dec counter
        ld a, b      ; check if bc == 0
        or c
    jr nz, _Vramcpy_loop ; jump if bc!=0
    call lcdon
    pop af
ret

; Mod: A
; de: dest ptr
; l:  value
; bc: dest len
memset:
    push af
    _memset_loop:
        ld a, l
        ld [de], a   ; store the value to dest
        inc de
        dec bc       ; dec counter
        ld a, b      ; check if bc == 0
        or c
    jr nz, _memset_loop ; jump if bc!=0
    pop af
ret

; Mod: A
; de: dest ptr
; l:  value
; bc: dest len
Vramset:
    push af 
    call lcdwait
    call lcdoff
    _Vramset_loop:
        ld a, l
        ld [de], a   ; store the value to dest
        inc de
        dec bc       ; dec counter
        ld a, b      ; check if bc == 0
        or c
    jr nz, _Vramset_loop ; jump if bc!=0
    call lcdon
    pop af
ret