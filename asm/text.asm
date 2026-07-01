;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;For use in asar2.
;
;Inserts text binaries created by utils/TextInserter.java.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
freespacebyte $62


segment bank=$03
Scene02:
	incbin "../script/binary/02.bin"

org $848380
	dw Scene02


segment bank=$03
Scene03:
	incbin "../script/binary/03.bin"

org $8487F1
	dw Scene03


segment bank=$03
Scene04:
	incbin "../script/binary/04.bin"

org $848A45
	dw Scene04


segment bank=$03
Scene05:
	incbin "../script/binary/05.bin"

org $8498B9
	dw Scene05


segment bank=$03
Scene06:
	incbin "../script/binary/06.bin"

org $849EF7
	dw Scene06


segment bank=$03
Scene07:
	incbin "../script/binary/07.bin"

org $84A347
	dw Scene07


segment bank=$03
Scene08:
	incbin "../script/binary/08.bin"

org $84A800
	dw Scene08


segment bank=$03
Scene09:
	incbin "../script/binary/09.bin"

org $84AF19
	dw Scene09


segment bank=$03
Scene0A:
	incbin "../script/binary/0A.bin"

org $84BC34
	dw Scene0A


segment bank=$03
Scene0B:
	incbin "../script/binary/0B.bin"

org $84B5C9
	dw Scene0B


segment bank=$03
Scene0C:
	incbin "../script/binary/0C.bin"

org $84D842
	dw Scene0C


segment bank=$03
Scene0D:
	incbin "../script/binary/0D.bin"

org $84DAB6
	dw Scene0D


segment bank=$03
Scene0E:
	incbin "../script/binary/0E.bin"

org $84E862
	dw Scene0E


segment bank=$03
Scene0F:
	incbin "../script/binary/0F.bin"

org $84EAFB
	dw Scene0F


segment bank=$03
Scene10:
	incbin "../script/binary/10.bin"

org $84ED01
	dw Scene10


segment bank=$03
Scene11:
	incbin "../script/binary/11.bin"

org $84EF84
	dw Scene11


segment bank=$03
Scene12:
	incbin "../script/binary/12.bin"

org $84F3EB
	dw Scene12


segment bank=$03
Scene13:
	incbin "../script/binary/13.bin"

org $84F77F
	dw Scene13


segment bank=$03
Scene14:
	incbin "../script/binary/14.bin"

org $858099
	dw Scene14


segment bank=$03
Scene15:
	incbin "../script/binary/15.bin"

org $85843A
	dw Scene15


segment bank=$03
Scene16:
	incbin "../script/binary/16.bin"

org $858996
	dw Scene16


segment bank=$03
Scene17:
	incbin "../script/binary/17.bin"

org $858BA3
	dw Scene17


segment bank=$03
Scene18:
	incbin "../script/binary/18.bin"

org $858E59
	dw Scene18


segment bank=$03
Scene19:
	incbin "../script/binary/19.bin"

org $85909B
	dw Scene19


segment bank=$03
Scene1A:
	incbin "../script/binary/1A.bin"

org $859353
	dw Scene1A


segment bank=$03
Scene1B:
	incbin "../script/binary/1B.bin"

org $8599AB
	dw Scene1B


segment bank=$03
Scene1C:
	incbin "../script/binary/1C.bin"

org $859CBB
	dw Scene1C


segment bank=$03
Scene1D:
	incbin "../script/binary/1D.bin"

org $85A6B9
	dw Scene1D


segment bank=$03
Scene1E:
	incbin "../script/binary/1E.bin"

org $85AC1F
	dw Scene1E


segment bank=$03
Scene1F:
	incbin "../script/binary/1F.bin"

org $85C7BC
	dw Scene1F


segment bank=$03
Scene20:
	incbin "../script/binary/20.bin"

org $85CAF4
	dw Scene20


segment bank=$03
Scene21:
	incbin "../script/binary/21.bin"

org $85CD77
	dw Scene21


segment bank=$03
Scene22:
	incbin "../script/binary/22.bin"

org $85D277
	dw Scene22


segment bank=$03
Scene01_0:
	incbin "../script/binary/01_0.bin"

org $85E6E2
	dw Scene01_0


segment bank=$03
Scene01_1:
	incbin "../script/binary/01_1.bin"

org $85E701
	dw Scene01_1


segment bank=$03
Scene01_2:
	incbin "../script/binary/01_2.bin"

org $85E720
	dw Scene01_2


segment bank=$03
Scene01_3:
	incbin "../script/binary/01_3.bin"

org $85E73F
	dw Scene01_3


segment bank=$03
Scene25:
	incbin "../script/binary/25.bin"

org $85E79C
	dw Scene25