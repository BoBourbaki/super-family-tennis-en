;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;For use in asar2.
;
;Inserts graphics binaries created by utils/GraphicsInserter.java.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
freespacebyte $62


segment
Font:
	incbin "../gfx/binary/font8x.bin"

org $038138
	db Font>>16
	LDY #Font


segment
TitleScreenLayer1Tilemap:
	incbin "../gfx/binary/title_screen_layer1_tilemap.bin"

org $02A4BE
	db TitleScreenLayer1Tilemap>>16
	LDY #TitleScreenLayer1Tilemap

org $02A626
	db TitleScreenLayer1Tilemap>>16
	db TitleScreenLayer1Tilemap>>16
	PLB
	PLB
	LDX #TitleScreenLayer1Tilemap


segment
TileScreenLayer3Tilemap:
	incbin "../gfx/binary/title_screen_layer3_tilemap.bin"

org $02A4E0
	db TileScreenLayer3Tilemap>>16
	LDY #TileScreenLayer3Tilemap


segment
TitleScreenMode7Tilemap:
	incbin "../gfx/binary/title_screen_mode7_tilemap.bin"

org $02A4F1
	db TitleScreenMode7Tilemap>>16
	LDY #TitleScreenMode7Tilemap


segment
TitleScreenMode7Tileset:
	incbin "../gfx/binary/title_screen_mode7_tileset.bin"

org $02A4FD
	db TitleScreenMode7Tileset>>16
	LDY #TitleScreenMode7Tileset


segment
TitleScreenLayer1Tileset:
	incbin "../gfx/binary/title_screen_layer1_tileset.bin"

org $02A617
	db TitleScreenLayer1Tileset>>16
	db TitleScreenLayer1Tileset>>16
	PLB
	PLB
	LDX #TitleScreenLayer1Tileset


segment
TileScreenLayer3Tileset:
	incbin "../gfx/binary/title_screen_layer3_tileset.bin"

org $02A644
	db TileScreenLayer3Tileset>>16
	db TileScreenLayer3Tileset>>16
	PLB
	PLB
	LDX #TileScreenLayer3Tileset


segment
PasswordOAM1Tileset:
	incbin "../gfx/binary/password_OAM1_tileset.bin"

org $048113
	db PasswordOAM1Tileset>>16
	db PasswordOAM1Tileset>>16
	PLB
	PLB
	LDX #PasswordOAM1Tileset


segment
Scene04NoteTileset:
	incbin "../gfx/binary/scene_04_note_tileset.bin"

org $048AE2
	db Scene04NoteTileset>>16
	db Scene04NoteTileset>>16
	PLB
	PLB
	LDX #Scene04NoteTileset


segment
Scene04NoteTilemap:
	incbin "../gfx/binary/scene_04_note_tilemap.bin"

org $048AF1
	db Scene04NoteTilemap>>16
	db Scene04NoteTilemap>>16
	PLB
	PLB
	LDX #Scene04NoteTilemap