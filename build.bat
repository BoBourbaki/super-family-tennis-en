set baseImage=Super Family Tennis (Japan).sfc
set newImage=Super Family Tennis English.sfc

del "%newImage%"
copy "%baseImage%" "%newImage%"

cd utils
::javac TextInserter.java
java TextInserter.java ..\script\english ..\script\binary
::javac GraphicsInserter.java
java GraphicsInserter.java ..\gfx\english ..\gfx\binary
cd ..

asar.exe --no-title-check asm\freespace.asm "%newImage%"
asar.exe asm\text.asm "%newImage%"
asar.exe asm\graphics.asm "%newImage%"
asar.exe asm\main.asm "%newImage%"