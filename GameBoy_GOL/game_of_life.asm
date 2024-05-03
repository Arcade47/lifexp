;--------------------------------------------------------
; File Created by SDCC : free open source ISO C Compiler 
; Version 4.3.2 #14228 (MINGW64)
;--------------------------------------------------------
	.module game_of_life
	.optsdcc -msm83
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _memcpy
	.globl _rand
	.globl _initrand
	.globl _get_bkg_tile_xy
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _GOL_4by4
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_GOL_4by4::
	.ds 224
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;game_of_life.c:17: void main(){
;	---------------------------------
; Function main
; ---------------------------------
_main::
	ld	hl, #-729
	add	hl, sp
	ld	sp, hl
;game_of_life.c:20: initrand(123);
	ld	de, #0x007b
	push	de
	call	_initrand
	pop	hl
;game_of_life.c:22: set_bkg_data(0, 14, GOL_4by4);
	ld	de, #_GOL_4by4
	push	de
	ld	hl, #0xe00
	push	hl
	call	_set_bkg_data
	add	sp, #4
;game_of_life.c:48: for (int i = 0; i < ARRAY_SIZE; i++) {
	ld	bc, #0x0000
00134$:
	ld	a, c
	sub	a, #0x68
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x81
	jr	NC, 00101$
;game_of_life.c:50: unsigned int r = (rand() % 2) * 13;
	push	bc
	call	_rand
	ld	a, e
	pop	bc
	and	a, #0x01
	ld	e, a
	add	a, a
	add	a, e
	add	a, a
	add	a, a
	add	a, e
	ld	hl, #728
	add	hl, sp
	ld	(hl), a
;game_of_life.c:51: GOL_tiles_test[i] = r;
	ld	hl, #0
	add	hl, sp
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	hl, #728
	add	hl, sp
	ld	a, (hl)
	ld	(de), a
;game_of_life.c:48: for (int i = 0; i < ARRAY_SIZE; i++) {
	inc	bc
	jr	00134$
00101$:
;game_of_life.c:56: set_bkg_tiles(0, 0, 20, 18, GOL_tiles_test);
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;game_of_life.c:58: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;game_of_life.c:59: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;game_of_life.c:61: while(1){
00131$:
;game_of_life.c:64: memcpy(GOL_tiles_test_copy, GOL_tiles_test, sizeof(GOL_tiles_test));
	ld	de, #0x0168
	push	de
	ld	hl, #2
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #362
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_memcpy
;game_of_life.c:68: for (int i = 1; i < GOL_tiles_testWidth - 1; i++) {
	ld	hl, #723
	add	hl, sp
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00140$:
	ld	hl, #723
	add	hl, sp
	ld	a, (hl+)
	sub	a, #0x13
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00287$
	bit	7, d
	jr	NZ, 00288$
	cp	a, a
	jr	00288$
00287$:
	bit	7, d
	jr	Z, 00288$
	scf
00288$:
	jp	NC, 00129$
;game_of_life.c:69: for (int j = 1; j < GOL_tiles_testHeight - 1; j++) {
	ld	hl, #725
	add	hl, sp
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00137$:
	ld	hl, #725
	add	hl, sp
	ld	a, (hl+)
	sub	a, #0x11
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00289$
	bit	7, d
	jr	NZ, 00290$
	cp	a, a
	jr	00290$
00289$:
	bit	7, d
	jr	Z, 00290$
	scf
00290$:
	jp	NC, 00141$
;game_of_life.c:71: int neighbours = 0;
	xor	a, a
	ld	hl, #727
	add	hl, sp
	ld	(hl+), a
	ld	(hl), a
;game_of_life.c:73: if (get_bkg_tile_xy(i-1, j-1) == 13) {neighbours += 1;}
	ld	hl, #725
	add	hl, sp
	ld	a, (hl)
	ld	hl, #720
	add	hl, sp
	ld	(hl), a
	ld	a, (hl+)
	inc	hl
	add	a, #0xff
	ld	(hl+), a
	ld	a, (hl-)
	dec	hl
	ld	(hl), a
	ld	a, (hl+)
	ld	b, a
	dec	b
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00103$
	ld	hl, #727
	add	hl, sp
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00103$:
;game_of_life.c:74: if (get_bkg_tile_xy(i+0, j-1) == 13) {neighbours += 1;}
	ld	hl, #722
	add	hl, sp
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00105$
	ld	hl, #727
	add	hl, sp
	inc	(hl)
	jr	NZ, 00295$
	inc	hl
	inc	(hl)
00295$:
00105$:
;game_of_life.c:75: if (get_bkg_tile_xy(i+1, j-1) == 13) {neighbours += 1;}
	ld	hl, #721
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	inc	c
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00107$
	ld	hl, #727
	add	hl, sp
	inc	(hl)
	jr	NZ, 00298$
	inc	hl
	inc	(hl)
00298$:
00107$:
;game_of_life.c:76: if (get_bkg_tile_xy(i-1, j+0) == 13) {neighbours += 1;}
	ld	hl, #720
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	push	bc
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00109$
	ld	hl, #727
	add	hl, sp
	inc	(hl)
	jr	NZ, 00301$
	inc	hl
	inc	(hl)
00301$:
00109$:
;game_of_life.c:78: if (get_bkg_tile_xy(i+1, j+0) == 13) {neighbours += 1;}
	ld	hl, #720
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	ld	a, c
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00111$
	ld	hl, #727
	add	hl, sp
	inc	(hl)
	jr	NZ, 00304$
	inc	hl
	inc	(hl)
00304$:
00111$:
;game_of_life.c:79: if (get_bkg_tile_xy(i-1, j+1) == 13) {neighbours += 1;}
	ld	hl, #720
	add	hl, sp
	ld	d, (hl)
	inc	d
	push	de
	ld	e, b
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	pop	de
	sub	a, #0x0d
	jr	NZ, 00113$
	ld	hl, #727
	add	hl, sp
	inc	(hl)
	jr	NZ, 00307$
	inc	hl
	inc	(hl)
00307$:
00113$:
;game_of_life.c:80: if (get_bkg_tile_xy(i+0, j+1) == 13) {neighbours += 1;}
	push	de
	push	de
	inc	sp
	ld	hl, #724
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	pop	de
	sub	a, #0x0d
	jr	NZ, 00115$
	ld	hl, #727
	add	hl, sp
	inc	(hl)
	jr	NZ, 00310$
	inc	hl
	inc	(hl)
00310$:
00115$:
;game_of_life.c:81: if (get_bkg_tile_xy(i+1, j+1) == 13) {neighbours += 1;}
	ld	e, c
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	sub	a, #0x0d
	jr	NZ, 00117$
	ld	hl, #727
	add	hl, sp
	inc	(hl)
	jr	NZ, 00313$
	inc	hl
	inc	(hl)
00313$:
00117$:
;game_of_life.c:84: if (get_bkg_tile_xy(i+0, j+0) == 13) {
	ld	hl, #720
	add	hl, sp
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	hl, #722
	add	hl, sp
	ld	(hl), e
;game_of_life.c:86: if (neighbours < 2) {GOL_tiles_test_copy[i+GOL_tiles_testWidth*j] = 0;}
	ld	hl,#0x2d5
	add	hl,sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	c, l
	ld	b, h
	ld	hl, #723
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	c, l
	ld	b, h
	ld	hl, #360
	add	hl, sp
	add	hl, bc
	ld	c, l
	ld	b, h
;game_of_life.c:84: if (get_bkg_tile_xy(i+0, j+0) == 13) {
	ld	hl, #722
	add	hl, sp
	ld	a, (hl)
	sub	a, #0x0d
	jr	NZ, 00123$
;game_of_life.c:86: if (neighbours < 2) {GOL_tiles_test_copy[i+GOL_tiles_testWidth*j] = 0;}
	ld	hl, #727
	add	hl, sp
	ld	a, (hl+)
	sub	a, #0x02
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00316$
	bit	7, d
	jr	NZ, 00317$
	cp	a, a
	jr	00317$
00316$:
	bit	7, d
	jr	Z, 00317$
	scf
00317$:
	jr	NC, 00119$
	xor	a, a
	ld	(bc), a
00119$:
;game_of_life.c:90: if (neighbours > 3) {GOL_tiles_test_copy[i+GOL_tiles_testWidth*j] = 0;}
	ld	hl, #727
	add	hl, sp
	ld	a, #0x03
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00318$
	bit	7, d
	jr	NZ, 00319$
	cp	a, a
	jr	00319$
00318$:
	bit	7, d
	jr	Z, 00319$
	scf
00319$:
	jr	NC, 00123$
	xor	a, a
	ld	(bc), a
00123$:
;game_of_life.c:92: if (get_bkg_tile_xy(i+0, j+0) == 0) {
	ld	hl, #720
	add	hl, sp
	ld	a, (hl+)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_get_bkg_tile_xy
	pop	hl
	ld	a, e
	or	a, a
	jr	NZ, 00138$
;game_of_life.c:94: if (neighbours == 3) {GOL_tiles_test_copy[i+GOL_tiles_testWidth*j] = 13;}
	ld	hl, #727
	add	hl, sp
	ld	a, (hl+)
	sub	a, #0x03
	or	a, (hl)
	jr	NZ, 00138$
	ld	a, #0x0d
	ld	(bc), a
00138$:
;game_of_life.c:69: for (int j = 1; j < GOL_tiles_testHeight - 1; j++) {
	ld	hl, #725
	add	hl, sp
	inc	(hl)
	jp	NZ,00137$
	inc	hl
	inc	(hl)
	jp	00137$
00141$:
;game_of_life.c:68: for (int i = 1; i < GOL_tiles_testWidth - 1; i++) {
	ld	hl, #723
	add	hl, sp
	inc	(hl)
	jp	NZ,00140$
	inc	hl
	inc	(hl)
	jp	00140$
00129$:
;game_of_life.c:99: memcpy(GOL_tiles_test, GOL_tiles_test_copy, sizeof(GOL_tiles_test_copy));
	ld	de, #0x0168
	push	de
	ld	hl, #362
	add	hl, sp
	ld	c, l
	ld	b, h
	ld	hl, #2
	add	hl, sp
	ld	e, l
	ld	d, h
	call	_memcpy
;game_of_life.c:101: set_bkg_tiles(0, 0, 20, 18, GOL_tiles_test);
	ld	hl, #0
	add	hl, sp
	push	hl
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
	jp	00131$
;game_of_life.c:133: }
	ld	hl, #729
	add	hl, sp
	ld	sp, hl
	ret
	.area _CODE
	.area _INITIALIZER
__xinit__GOL_4by4:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.area _CABS (ABS)
