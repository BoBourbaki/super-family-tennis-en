;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;For use in asar2.
;
;Marks regions of the ROM as freespace. Also sets the ROM title.
;
;62 is used to denote freespace since its the byte that appears the least consecutive times in the ROM (only once).
;This prevents asar's "freecode" command from accidentally overwriting non-freespace.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
check bankcross off
padbyte $62


;Set ROM title.
org $80FFC0
	db "SUPER FAMILY TENNIS  "


;Mark unused regions as freespace.
;$10 byte buffer at the start of each to reduce risk of overwriting used data. $4C42 bytes of freespace.
org $81DB75 + $10
pad $828000
org $82FB61 + $10
pad $838000
org $83FB09 + $10
pad $848000
org $84F9E8 + $10
pad $858000
org $85F585 + $10
pad $868000
org $86FF00 + $10
pad $878000
org $8AF880 + $10
pad $8B8000
org $9BFBD6 + $10
pad $9C8000
org $9EFE8C + $10
pad $9F8000


;Mark old script data as freespace. $37E4 bytes of contiguous freespace.
org $83B5D1 ;Scene 02
pad $83B7AF
org $83B7AF ;Scene 03
pad $83B7F3
org $83B7F3 ;Scene 04
pad $83B9CB
org $83B9CB ;Scene 05
pad $83BC07
org $83BC07 ;Scene 06
pad $83BC67
org $83BC67 ;Scene 07
pad $83BD01
org $83BD01 ;Scene 08
pad $83BFAB
org $83BFAB ;Scene 09
pad $83C1F5
org $83C1F5 ;Scene 0A
pad $83C287
org $83C287 ;Scene 0B
pad $83C457
org $83C457 ;Scene 0C
pad $83C4B3
org $83C4B3 ;Scene 0D
pad $83C64B
org $83C64B ;Scene 0E
pad $83C727
org $83C727 ;Scene 0F
pad $83C7AB
org $83C7AB ;Scene 10
pad $83C813
org $83C813 ;Scene 11
pad $83CA6B
org $83CA6B ;Scene 12
pad $83CB01
org $83CB01 ;Scene 13
pad $83CBB9
org $83CBB9 ;Scene 14
pad $83CD5F
org $83CD5F ;Scene 15
pad $83CF39
org $83CF39 ;Scene 16
pad $83CFEB
org $83CFEB ;Scene 17
pad $83D0E9
org $83D0E9 ;Scene 18
pad $83D197
org $83D197 ;Scene 19
pad $83D277
org $83D277 ;Scene 1A
pad $83D52F
org $83D52F ;Scene 1B
pad $83D5B7
org $83D5B7 ;Scene 1C
pad $83D9EB
org $83D9EB ;Scene 1D
pad $83DD95
org $83DD95 ;Scene 1E
pad $83DFBB
org $83DFBB ;Scene 1F
pad $83E021
org $83E021 ;Scene 20
pad $83E079
org $83E079 ;Scene 21
pad $83E1ED
org $83E1ED ;Scene 22
pad $83E6B9
org $83E6B9 ;Scene 01_0
pad $83E785
org $83E785 ;Scene 01_1
pad $83E829
org $83E829 ;Scene 01_2
pad $83E8C9
org $83E8C9 ;Scene 01_3
pad $83E975
org $83E975 ;Scene 25
pad $83EDB5


;Mark old graphics data as freespace.
org $138000 ;Font graphics ($257B bytes)
pad $13A57B
org $14DF57 ;Title screen layer 1 tileset ($109A bytes)
pad $14EFF1
org $18DD1C ;Title screen layer 1 tilemap ($04D2 bytes)
pad $18E1EE
org $17880E ;Title screen layer 3 tileset ($0804 bytes)
pad $179012
org $198432 ;Title screen layer 3 tilemap ($0431 bytes)
pad $198863
org $17C61E ;Title screen mode 7 tileset ($0730 bytes, $0E6F contiguous with Scene 04 layer 2 tileset)
pad $17CD4E
org $19E702 ;Title screen mode 7 tilemap ($01DA bytes)
pad $19E8DC
org $16DDF8 ;Password screen OAM1 tileset ($08BC bytes)
pad $16E6B4
org $17BEDF ;Scene 04 layer 2 tileset ($073F bytes, $0E6F contiguous with Title screen mode 7 tileset)
pad $17C61E
org $19F522 ;Scene 04 layer 2 tilemap ($019F bytes)
pad $19F6C1
org $15EAE9 ;Sign layer 3 tileset ($0A62 bytes)
pad $15F54B
org $16B089	;Sign layer 3 tilemaps ($0939 bytes)
pad $16B9C2


;Expands the ROM to 1280 KB. Uncomment this code if ROM expansion is necessary. If expansion is necessary and this code
;is not uncommented, Asar will expand the ROM to 2048 KB, leaving more than 24 banks of empty space in the final build.
org $A08000
pad $A88000
org $80FFD7 ;Corrects ROM size in header.
	db $0B