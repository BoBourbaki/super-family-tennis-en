# Super Family Tennis English Translation
*Super Family Tennis* is a 1993 tennis game released by Namco for the Super Famicom. It is a part of Namco's "Family" line of sports game, and is a follow up to their previous Tennis games, *Family Tennis* and *Pro Tennis: World Court*.

*Super Family Tennis* was released in Europe as *Smash Tennis*. However, this version is heavily flawed. Most pressingly, it entirely removes the game's story mode, "Namcot Theater." It also changes the name of every character, court, and tournament, replaces the animated tournament mode intermissions with a bland static screens, and being as it was only released in PAL regions, it is locked to 50 Hz.

The goal of this project is to translate the original, superior Japanese version of the game. As of right now, the project is not complete.

## File Structure
* **asm** - Contains various .asm files that are applied to the base ROM.
	* **freespace.asm** - Fills data regions to be replaced with free space byte $62 so that data and code can be allocated with Asar2's "segment" command.
	* **text.asm** - Inserts text binaries created by "utils/TextInserter.java".
	* **graphics.asm** - Inserts graphics binaries created by "utils/GraphicsInserter.java".
	* **main.asm** - Applies various assembly code changes required for the game to support English text.
* **utils** - Contains various Java programs executed during the build process.
	* **TextInserter.java** - Converts the translated text files from "script/english" to the text encoding scheme used by the cutscene engine. Writes to "script/binary".
	* **GraphicsInserter.java** - Converts the uncompressed graphics files from "gfx/english" to the compressed format used by the game. Writes to "gfx/binary".
	* **TextExtractor.java** - Extracts text from the game's cutscene engine. This program is not executed during the build process and is only included for reference. Can be ran by running
		```console
		java TextExtractor "..\Super Family Tennis (Japan).sfc" "..\script\japanese"
		```
		in the utils directory. The constant CONTROL_CHARACTERS_ENABLED can be changed from true to false to generate a version of the text without control codes.
* **gfx** - Contains graphics assets edited as a part of this translation project.
	* **binary** - Compressed output files of "utils/GraphicsInserter.java". Inserted to the ROM by "asm/graphics.asm". Files are written during the build process.
	* **english** - Uncompressed English graphics assets. Files are read by "utils/GraphicsInserter.java" during the build process. 
	* **japanese** - Original uncompressed Japanese graphics assets. Manually extracted from VRAM. Files are neither read nor written during the build process. Included for reference.
* **script** - Contains text used by the cutscene engine.
	* **binary** - Output files of "utils/TextInserter.java". Inserted to the ROM by "asm/text.asm". Files are written during the build process.
	* **english** - Translated text files. Files are read by "utils/TextInserter.java" during the build process.
	* **japanese** - Original Japanese text files. Created by "utils/TextExtractor". Files are neither read nor written during the build process. Included for reference.
* **notes** - Various notes about the inner workings of *Super Family Tennis* that may come in handy to any future hackers of this game.
	* **Context.txt** - Contains descriptions of what each scene in the cutscene engine is.
	* **DebugMode.txt** - Documents a left over debug mode accessible via memory editing.
	* **Freespace.txt** - A list of unused memory regions at the end of each data bank.
	* **OtherText.txt** - Contains a list of every piece of Japanese text in the game not covered by the cutscene engine text extraction. Most of these are embedded in graphics.
	* **OtherTextTranslated** - Same as "OtherText.txt" except it contains a translation of each piece of text.
	* **Super Family Tennis (Japan).mlb** - Debugger label file for the Mesen2 emulator. Labels various subroutines and variables. Labels can be imported to Mesen's debugger through "File --> Workspace --> Import labels...". Variables names are prefixed with an @, and code labels are prefixed with an _. Done for convenience when scrolling throuh the Labels window in Mesen.

## Notes
Here is some useful information for anyone looking to contribute to this project or use it as a base for a future project.
* Script
	* The cutscene engine does not linebreak automatically. Any line of text exceeding the 28 tile width of the text box will cause graphical errors.
	* The \{Prompt\} control code works by drawing the cursor as if it was a character. The cursor position must be manually aligned with spaces.
	* Writing a hexadecimal number in curly brackets is equivalent to writing the character with the corresponding ID. For example, writing \{00\}\{01\}\{02\} is the same as writing ABC. This allows you to write characters that are available in the font but not implemented in the inserter.
	* Quotation marks alternate between open and closed quotes. If for some reason you want to write double quotes, you can use \{8D\} as an open quote and \{8E\} as a closed quote. For example, \{8D\}\{8D\}Hi\{8E\}\{8E\} would display as \""Hi\"".
	* The control codes \{Clear\} and \{Prompt\} must always be followed by two new lines.
* Graphics
	* The graphics assets in "gfx/japanese" and "gfx/english" are stored exactly as they are in VRAM. For more information, see the SNESdev Wiki's articles on [tilemaps](https://snes.nesdev.org/wiki/Tilemaps), [tiles](https://snes.nesdev.org/wiki/Tiles), and [palettes](https://snes.nesdev.org/wiki/Palettes).

## Building
Requires Java to be installed.

Place the base ROM "Super Family Tennis (Japan).sfc" in the root directory of the directory.
* Base ROM checksum:
	* CRC32: 2BCBFF26
	* MD5: 6980F890A84995D1A9FF8E135995E077
	* SHA-1: AD0E94A522CC653EC4E166E40463E793787C61CA
	* SHA-256: 9D4D4B5A22D0B6A522599BD1B72F626D11018333B9350416D12FD85E0274C101

Run build.bat. If the resulting ROM is 2048 KB, I would advise uncommenting the last 4 lines of asm/freespace.asm to build a ROM that is 1280 KB.

Linux users are on their own.

## Credits
- BoBourbaki - Hacking
- DeMille - Translation