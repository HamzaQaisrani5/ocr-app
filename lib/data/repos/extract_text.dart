import 'dart:developer';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class ExtractText {
  Future<String?> extractedText(File photo) async {
    try {
      if (photo.path.isNotEmpty) {
        final InputImage inputImage = InputImage.fromFile(photo);
        final TextRecognizer textRecognizer = TextRecognizer(
          script: TextRecognitionScript.latin,
        );
        final RecognizedText recognizedText = await textRecognizer.processImage(
          inputImage,
        );
        return recognizedText.text;
      }
      return null;
    } catch (e) {
      log('Exception of extractedtext(): $e');
    }
    return null;
  }

  String? filtertext(String? extractText) {
    if (extractText != null) {
      final regex = RegExp(r'\d{5}-\d{7}-\d{1}');
      final match = regex.firstMatch(extractText);
      if (match != null) {
        return match.group(0).toString();
      }
      return 'No match found';
    }
    return null;
  }
}
