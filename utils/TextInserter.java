//Utility for creating text binaries used by asm/text.asm.

import java.io.File;
import java.io.IOException;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Arrays;

public class TextInserter {
	
	public static final String ENGLISH_FONT = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzAAAACEEEEIIIINOOOOEUUUUaaaaceeeeiiiinooooeuuuuBoarr______0123456789 __,._:;?!_____/_~___'\"_()[]______+-___=_<>___$%#&*@_____"; //TODO: replace placeholders with proper font characters. Needed for translations to non-English languages.
	
	public static final String[] CUTSCENE_FILE_NAMES = {"02", "03", "04", "05",
														"06", "07", "08", "09",
														"0A", "0B", "0C", "0D",
														"0E", "0F", "10", "11",
														"12", "13", "14", "15",
														"16", "17", "18", "19",
														"1A", "1B", "1C", "1D",
														"1E", "1F", "20", "21",
														"22", "01_0", "01_1",
														"01_2", "01_3", "25"};
	
	public static void main(String[] args) {
		if (args.length != 2) {
            System.out.println("Usage: java TextExtractor <inputDirectory> <outputDirectory>");
            return;
        }
        String inputDirectory = args[0];
		String outputDirectory = args[1];
		try {
			for (int i = 0; i < CUTSCENE_FILE_NAMES.length; i++) {
				BufferedReader reader = new BufferedReader(new FileReader(inputDirectory + "/" + CUTSCENE_FILE_NAMES[i] + ".txt"));
				byte[] textBinary = convertText(reader, CUTSCENE_FILE_NAMES[i]);
				FileOutputStream stream = new FileOutputStream(outputDirectory + "/" + CUTSCENE_FILE_NAMES[i] + ".bin");
				stream.write(textBinary);
			}
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
	}
	
	public static byte[] convertText(BufferedReader reader, String fileName) throws IOException {
		ArrayList<Byte> binary = new ArrayList<Byte>();
		int quoteCount = 0;
		loop: while (true) {
			int characterInt = reader.read();
			if (characterInt == -1) {
				break;
			}
			char character = (char)characterInt;
			if (character == '{') {
				char[] controlChars = new char[20];
				int i = 0; 
				while (true) {
					characterInt = reader.read();
					if (characterInt == -1) {
						break loop;
					}
					character = (char)characterInt;
					if (character == '}') {
						break;
					}
					controlChars[i++] = character;
				}
				String controlCode = new String(Arrays.copyOf(controlChars, i));
				if (controlCode.length() < 5) {
					controlCode = controlCode + "     ";
				}
				switch (controlCode.substring(0, 5)) {
					case "Clear":
						binary.add((byte)0x01);
						binary.add((byte)0xC0);
						if (reader.read() + reader.read() != (int)'\n' * 2) {
							System.out.println("Warning: {Clear} control code not followed by two new lines in " + fileName + ".txt.");
						}
						break;
					case "Promp":
						binary.add((byte)0x02);
						binary.add((byte)0xC0);
						if (reader.read() + reader.read() != (int)'\n' * 2) {
							System.out.println("Warning: {Prompt} control code not followed by two new lines in " + fileName + ".txt.");
						}
						break;
					case "Next ":
						binary.add((byte)0x03);
						binary.add((byte)0xC0);
						break;
					case "Music":
						binary.add((byte)Integer.parseInt(controlCode.substring(7)));
						binary.add((byte)0xD0);
						break;
					case "Speed":
						binary.add((byte)Integer.parseInt(controlCode.substring(7)));
						binary.add((byte)0xF0);
						break;
					default:
						try {
							binary.add((byte)Integer.parseInt(controlCode.trim(), 16));
						} catch (NumberFormatException e) {}
						break;
				}
			} else if (character == '\n') {
				binary.add((byte)0x00);
				binary.add((byte)0xC0);
			} else if (character == '"') {
				int charConverted = ENGLISH_FONT.indexOf(characterInt);
				binary.add((byte)(charConverted + quoteCount++ % 2));
			} else {
				int charConverted = ENGLISH_FONT.indexOf(characterInt);
				if (charConverted != -1) {
					binary.add((byte)charConverted);
				}
			}
		}
		return arrayListToPrimitiveByteArray(binary);
	}
	
	public static byte[] arrayListToPrimitiveByteArray(ArrayList<Byte> list) {
		byte[] result = new byte[list.size()];
		for (int i = 0; i < result.length; i++) {
			result[i] = list.get(i).byteValue();
		}
		return result;
	}
	
}