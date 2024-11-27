INCLUDE "hardware.inc"
INCLUDE "lcd.s"
INCLUDE "stdlib.s"
INCLUDE "stdio.s"
INCLUDE "tiles.s"

SECTION "Header", ROM0[$100]
    jp EntryPoint
    ds $150 - @, 0 ; Make room for the header

SECTION "Code", ROM0
EntryPoint:    
    ; clear all VRam memory
    ld de, $8000
    ld hl, 0
    ld bc, $9C00 - $8000
    call Vramset
    
    
    ; Load tile data into VRAM
    ld hl, tiles
    ld de, $8000
    ld bc, tiles_end - tiles
    call Vramcpy
    
    call stdio_init
    
    ld hl, msg
    call puts

loop:
    halt
    jp loop
    
msg:
    db "Hello, World!", 0