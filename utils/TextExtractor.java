//Utility for extracting cutscene text.

import java.io.File;
import java.io.IOException;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.nio.file.Files;
import java.nio.file.Paths;

public class TextExtractor {
	
	public static final String FONT = "あいうえおかきくけこさしすせそたちつてとなにぬねのはひふへほまみむめもやゆよらりるれろわをんぁぃぅぇぉっゃゅょ♥~。!?*アイウエオカキクケコサシスセソタチツテトナニヌネノハヒフヘホマミムメモヤユヨラリルレロワヲンァィゥェォッャュョ『ー…「」』がぎぐげごガギグゲゴざじずぜぞザジズゼゾだぢづでどダ成ヅデドばびぶべぼバビブベボぱぴぷぺぽパピプペポ栄光南十字星最後牧野今日軽井沢準決勝究極第一歩気負優妹足逆安心好実力方北海道着強烈前特訓挑完戦沖縄悔手全相年半怒脅顔迫状神社午返時兄協件落得島世界中真三意孤達抜涙笑存分調子、贈楽初~大切紙失礼彼女恋人関係低夢中休13ABCDEFGHIJKLMNOPQRSTUVWXYZ・.-,&四会同回5遠永  ";
	public static final String[] CONTROL_CHARACTERS = {"\n", "{Clear}\n\n", "{Prompt}\n\n", "{Next Scene}"};
	public static final String[] CONTROL_CHARACTERS_ALT = {"\n", "\n\n", "\n\n", ""};
	
	public static final boolean CONTROL_CHARACTERS_ENABLED = true;
	
	public static byte[] rom;
	
	public static final int CUTSCENE_BANK = 0x030000; //CPU Address.
	public static final int[] CUTSCENE_TEXT_POINTER_ADDRESSES = {0x020380, 0x0207F1, 0x020A45, 0x0218B9, //PRG Addresses.
																 0x021EF7, 0x022347, 0x022800, 0x022F19,
																 0x023C34, 0x0235C9, 0x025842, 0x025AB6,
																 0x026862, 0x026AFB, 0x026D01, 0x026F84,
																 0x0273EB, 0x02777F, 0x028099, 0x02843A,
																 0x028996, 0x028BA3, 0x028E59, 0x02909B,
																 0x029353, 0x0299AB, 0x029CBB, 0x02A6B9,
																 0x02AC1F, 0x02C7BC, 0x02CAF4, 0x02CD77,
																 0x02D277, 0x02E6E2, 0x02E701,
																 0x02E720, 0x02E73F, 0x02E79C};
																
	public static final int[] CUTSCENE_LENGTHS =   {0x1DE, 0x044, 0x1D8, 0x23C,
													0x060, 0x09A, 0x2AA, 0x24A,
													0x092, 0x1D0, 0x05C, 0x198,
													0x0DC, 0x084, 0x068, 0x258,
													0x096, 0x0B8, 0x1A6, 0x1DA,
													0x0B2, 0x0FE, 0x0AE, 0x0E0,
													0x2B8, 0x088, 0x434, 0x3AA,
													0x226, 0x066, 0x058, 0x174,
													0x4CC, 0x0CC, 0x0A4,
													0x0A0, 0x0AC, 0x440};
	
	public static final String[] CUTSCENE_FILE_NAMES = {"02.txt", "03.txt", "04.txt", "05.txt",
														"06.txt", "07.txt", "08.txt", "09.txt",
														"0A.txt", "0B.txt", "0C.txt", "0D.txt",
														"0E.txt", "0F.txt", "10.txt", "11.txt",
														"12.txt", "13.txt", "14.txt", "15.txt",
														"16.txt", "17.txt", "18.txt", "19.txt",
														"1A.txt", "1B.txt", "1C.txt", "1D.txt",
														"1E.txt", "1F.txt", "20.txt", "21.txt",
														"22.txt", "01_0.txt", "01_1.txt",
														"01_2.txt", "01_3.txt", "25.txt"};
	
	public static void main(String[] args) {
		if (args.length != 2) {
            System.out.println("Usage: java TextExtractor <superFamilyTennisROM> <outputDirectory>");
            return;
        }
        String romPath = args[0];
		String outputDirectory = args[1];
		try {
			rom = Files.readAllBytes(Paths.get(romPath));
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
		for (int i = 0; i < CUTSCENE_TEXT_POINTER_ADDRESSES.length; i++) {
			int cutScenePointer = getPrgMapAddress(get16BitLittleEndian(CUTSCENE_TEXT_POINTER_ADDRESSES[i]) + CUTSCENE_BANK);
			String cutSceneText = extractText(cutScenePointer, CUTSCENE_LENGTHS[i]);
			try (BufferedWriter writer = new BufferedWriter(new FileWriter(outputDirectory + "/" + CUTSCENE_FILE_NAMES[i]))) {
				writer.write(cutSceneText);
			} catch (IOException e) {
				e.printStackTrace();
				return;
			}
		}
	}
	
	public static int getCpuMapAddress(int prgMapAddress) {
		if (prgMapAddress > 0x0FFFFF) {
			System.out.println("Error: Cannot convert unmapped address.");
			return -1;
		}
		return (1 + prgMapAddress / 0x8000) * 0x8000 + prgMapAddress;
	}
	
	public static int getPrgMapAddress(int cpuMapAddress) { //Does not properly handle case of cpuMapAddress not mapping to PRG.
		return (cpuMapAddress - (cpuMapAddress / 0x8000 / 2 + 1) * 0x8000) % 0x100000;
	}
	
	public static int get16BitLittleEndian(int address) {
		return Byte.toUnsignedInt(rom[address]) + (Byte.toUnsignedInt(rom[address + 1]) << 8);
	}
	
	public static String extractText(int pointerToText, int length) {
		StringBuilder string = new StringBuilder();
		for (int i = 0; i < length; i += 2) {
			int character = get16BitLittleEndian(pointerToText + i);
			if ((character & 0xF000) == 0x8000) {
				if (CONTROL_CHARACTERS_ENABLED) {
					string.append(CONTROL_CHARACTERS[character & 0xFF]);
				} else {
					string.append(CONTROL_CHARACTERS_ALT[character & 0xFF]);
				}
			}
			if (CONTROL_CHARACTERS_ENABLED) {
				switch (character & 0xF000) {
					case 0x9000:
						string.append("{Music: " + (character & 0xFF) + "}");
						break;
					case 0xB000:
						string.append("{Speed: " + (character & 0xFF) + "}");
						break;
				}
			}
			if (character < 0x8000) {
				string.append(FONT.charAt(character));
			}
		}
		return string.toString();
	}
	
}