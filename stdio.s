SECTION "stdio", ROM0

;used to calculate the char position on the screen
DEF NextCharX EQU $C000
DEF NextCharY EQU $C001

;Mod: hl, a
stdio_init:
    ld hl, $FF42
    ld a, 0
    ldi [hl], a
    ld [hl], a
    ld [NextCharX], a
    ld [NextCharY], a
ret

; a: char to print 
putc:
    push af
    push bc
    push hl
    ; current font starts from 'space' at 0, so i sub 32 from every char
    sub 32
    ld b, a             ; temporarely store A in B
    ld hl, $9800        ; screen buffer start in HL
    
    ; calculate char position on the screen and then increment the X pos
    ld a, [NextCharX]   
    ld c, a             ; move current X to C
    add 1
    ld [NextCharX], a   ; save back X+1
    ld a, b             ; copy the char back to A
    ld b, 0             ; Hibyte 0 because x offset is 8bit value
    add hl, bc          ; finally calculate the offset $9800 + X
    ld [hl], a          ; store the char to screen
    pop hl
    pop bc
    pop af
ret

__puts:
    ld a, [hli]         ; copy in A the value currently pointed by hl then increment hl
    cp 0                ; check if there's 0 into A
    ret z               ; true -> return
    call putc           ; false -> print the char and jump back to __puts
jp __puts

; hl: zstr address
puts:
    ; wrapper to __puts
    ; simply turns off the screen for saving data into Vram 
    ; without having to wait for Vblank
    call lcdwait
    call lcdoff
    call __puts
    call lcdon
ret
