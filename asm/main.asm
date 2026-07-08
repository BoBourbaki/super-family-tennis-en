;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;For use in asar2.
;
;Main code changes.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
freespacebyte $62



;Change control codes from 8000, 9000, and B000 to C000, D000, and F000 respectively.
;Done so single byte encoded characters cover a bigger range.
org $0383FD
ParseNextChar:
	LDA $00FFF0
	BEQ ++
	LDA $60
	BIT #$C0C0
	BNE +
++:
	DEC $0788
	BNE ++
+:
	LDA $078A
	STA $0788
	LDX $078C
	LDA $0000,X
	CMP #$C000
	BCC PrintNormalChar
	INX
	INX
	STX $078C
	CMP #$D000
	BCC C0ControlCode
	CMP #$E000
	BCS +
	JMP $85B6
+:
	CMP #$F000
	BCS +
	JMP $85CD
+:
	JMP $85DC
++:
	CLC
	RTS

;Makes normal characters only 1 byte long.
PrintNormalChar:
	AND #$00FF
	
C0ControlCode = $038496



;Edits the palette of text in the cutscene engine.
org $03816A
	JSL NewSetCharacterColor
	padbyte $EA
	pad $03817C
	
segment
NewSetCharacterColor:
	;LDA #$5EF7 ;Light gray (used for shading)
	LDA #$0000 ;Black
	STA $0300
	LDA #$7FFF ;White
	STA $0302
	LDA #$109C ;Red (used for heart)
	STA $0304
	LDA #$0000 ;Black
	STA $0306
	RTL

org $1AA7DC ;Change palette of text on sign screens.
	dw $6620, $7FFF, $1DB9, $5EF7

org $08FF8B ;Change palette of multitap warning.
	dw $000C, $7FFF, $001F, $5EF7
	dw $3800, $371F, $001F, $0012
	dw $3CC6, $4508, $4D4A, $558C
	dw $4D4A, $4508, $3CC6, $3400



;Make text speed changes more granular.
;org $0385DC
;	AND #$00FF
;	NOP
;	NOP



;Make font 8 wide. Temporary measure until I finish implementing VWF.
org $038446
	dl $4300F4 ;PEA #$4300 
	PLD
	ASL ;Removed an ASL
	ASL
	ASL
	ASL
	ASL
	ADC #$A000
	STA $02
	SEP #$20
	LDA #$7E
	STA $04
	LDA #$18
	STA $01
	LDX #$0020 ;Changed from $40 to $20
	STX $05
	LDA #$01
	STA $00
	dl $0000F4 ;PEA #$0000 
	PLD
	REP #$20
	LDA $078E
	ASL
	ASL
	ASL
	ADC #$7000
	STA $07F0
	LDA #$0001
	STA $90
	INC $0790
	LDA $078E
	CLC
	ADC #$0002 ;Changed from $04 to $02
	CMP #$017C
	BCC +
	SBC #$017C
+:
	STA $078E
	CLC
	RTS
	padbyte $EA
	pad $038496

;Adjust new lines.	
org $0384A6
	LDA #$001C ;Change characters per line from 14 to 28.
	SEC
	SBC $0790
	NOP

;Making the blinking cursor 16x16 instead of 8x8 will be a part of the VWF changes.
;Change input prompt graphics offsets.
org $038572
	LDX #$00B1 ;Blank
org $03857C
	LDX #$00B0 ;Cursor

;Make the input prompt not completely break everything.
org $03858A
	SBC #$0002
	STA $078E



;[[ TODO: Finish this.
;Edit character printing routine to support a variable width font.
!texttilesbufferlength = $3800 ;Enough for 16 lines of text.
TextTilesBuffer = $7EA010
PixelOffsetIntoLine = $7EA000

PointerIntoTextTilesBuffer = $30
PointerIntoGraphics = $33

;The original character printing routine works as follows:
;When the cutscene engine is initiated, load font graphics from $7EA000 - 7EEFFF.
;Set the DMA registers according to the character being printed such that the character's graphics are the
;ones that get DMAed into VRAM.

org $03813C
	JSL InitializeVwfMemory ;Replace call to DecompressionRoutine that loads font graphics with call to InitializeVwfMemory.

org $038446
	dl $4300F4 ;PEA #$4300 
	PLD
	ASL
	ASL
	ASL
	ASL
	ASL
	ASL
	ADC #$A000
	STA $02
	SEP #$20
	LDA #$7E
	STA $04
	LDA #$18
	STA $01
	LDX #$0040
	STX $05
	LDA #$01
	STA $00
	dl $0000F4 ;PEA #$0000 
	PLD
	REP #$20
	LDA $078E
	ASL
	ASL
	ASL
	ADC #$7000
	STA $07F0
	LDA #$0001
	STA $90
	INC $0790
	LDA $078E
	CLC
	ADC #$0004
	CMP #$017C
	BCC +
	SBC #$017C
+:
	STA $078E
	CLC
	RTS
	padbyte $EA
	pad $038496


segment
FontGraphics:
	incbin "../gfx/binary/font.bin"
FontSpaceTable:
	incbin "../gfx/binary/fontspacetable.bin"
InitializeVwfMemory:
	LDA #$00
	LDY #!texttilesbufferlength
	LDX #TextTilesBuffer
-:
	STA $0000,X
	INX
	DEY
	BNE -
	RTL

;	LDA #TextTilesBuffer>>8&$FF00
;	STA PointerIntoTextTilesBuffer+1
;	LDA #TextTilesBuffer
;	STA PointerIntoTextTilesBuffer
;	LDA #$0000
;	LDY #!texttilesbufferlength-2
;-:
;	STA (PointerIntoTextTilesBuffer), Y
;	DEY
;	DEY
;	BNE -
;	RTL
]] :