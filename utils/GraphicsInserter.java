//Utility for creating graphics binaries used by asm/graphics.asm.

import java.io.File;
import java.io.IOException;
import java.io.FileReader;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;

public class GraphicsInserter {
	
	public static final String[] GRAPHICS_FILE_NAMES = {"font8x.bin",
														"title_screen_layer1_tilemap.bin",
														"title_screen_layer3_tilemap.bin",
														"title_screen_mode7_tilemap.bin",
														"title_screen_mode7_tileset.bin",
														"title_screen_layer1_tileset.bin",
														"title_screen_layer3_tileset.bin",
														"password_OAM1_tileset.bin",
														"scene_04_note_tileset.bin",
														"scene_04_note_tilemap.bin"};
	
	public static void main(String[] args) {
		if (args.length != 2) {
            System.out.println("Usage: java TextExtractor <inputDirectory> <outputDirectory>");
            return;
        }
        String inputDirectory = args[0];
		String outputDirectory = args[1];
		try {
			for (int i = 0; i < GRAPHICS_FILE_NAMES.length; i++) {
				byte[] graphicsUncompressed = Files.readAllBytes(Paths.get(inputDirectory + "/" + GRAPHICS_FILE_NAMES[i]));
				byte[] graphicsCompressed = compressGraphics(graphicsUncompressed);
				FileOutputStream stream = new FileOutputStream(outputDirectory + "/" + GRAPHICS_FILE_NAMES[i]);
				stream.write(graphicsCompressed);
			}
		} catch (IOException e) {
			e.printStackTrace();
			return;
		}
	}
	
	public static byte[] compressGraphics(byte[] uncompressed) throws IOException {
		ArrayList<Byte> binary = new ArrayList<Byte>();
		int byteCounter = 0;
		while (byteCounter < uncompressed.length) {
			byte controlByte = 0;
			byte[] buffer = new byte[14];
			int bufferCounter = 0;
			int bit = 0;
			while (bit < 7) {
				int duplicateScan = byteCounter - 256;
				if (duplicateScan < 0) {
					duplicateScan = 0;
				}
				int longestCopyLength = 1;
				int longestCopyOffset = 0;
				while (duplicateScan < byteCounter) {
					int currentCopyLength = 0;
					while (byteCounter + currentCopyLength < uncompressed.length && uncompressed[duplicateScan + currentCopyLength] == uncompressed[byteCounter + currentCopyLength]) {
						currentCopyLength++;
					}
					if (currentCopyLength > longestCopyLength) {
						longestCopyLength = currentCopyLength;
						longestCopyOffset = 256 - byteCounter + duplicateScan;
						if (longestCopyLength >= 255) {
							longestCopyLength = 255;
							break;
						}
					}
					duplicateScan++;
				}
				if (byteCounter >= uncompressed.length) {
					break;
				} else if (longestCopyLength < 3) {
					//Setting this constant to 3 makes the output identical to the compressed data in the ROM. 
					//I thought setting it to 2 would reduce the total number of control bytes
					//at a rate of 1 byte saved per 8 instances of "longestCopyLength = 2", but in practise this is not the case.
					buffer[bufferCounter] = uncompressed[byteCounter];
					bufferCounter++;
					byteCounter++;
					controlByte += (int)Math.pow(2, bit);
				} else {
					buffer[bufferCounter] = (byte)longestCopyLength;
					bufferCounter++;
					buffer[bufferCounter] = (byte)longestCopyOffset;
					bufferCounter++;
					byteCounter += longestCopyLength;
				}
				bit++;
			}
			controlByte += (int)Math.pow(2, bit);
			binary.add(controlByte);
			for (int i = 0; i < bufferCounter; i++) {
				binary.add(buffer[i]);
			}
		}
		binary.add((byte)0);
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