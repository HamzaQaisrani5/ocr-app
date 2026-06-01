import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraRepo {
  Future<File?> captureImage() async {
    final ImagePicker image = ImagePicker();
    try {
      final XFile? photo = await image.pickImage(source: ImageSource.camera);
      if (photo != null) {
        final imageFile = File(photo.path);
        return imageFile;
      }
    } catch (e) {
      log('Exception of captureImage(): $e');
    }
    return null;
  }

  // Future<String?> extractedText(File photo) async {
  //   try {
  //     if (photo.path.isNotEmpty) {
  //       final InputImage inputImage = InputImage.fromFile(photo);
  //       final TextRecognizer textRecognizer = TextRecognizer(
  //         script: TextRecognitionScript.latin,
  //       );
  //       final RecognizedText recognizedText = await textRecognizer.processImage(
  //         inputImage,
  //       );
  //       return recognizedText.text;
  //     }
  //     return null;
  //   } catch (e) {
  //     log('Exception of extractedtext(): $e');
  //   }
  //   return null;
  // }

  // String? filterText(String extractedText) {
  //   if (extractedText.isNotEmpty) {
  //     try {
  //       final regex = RegExp(r'\d{5}-\d{7}-\d');
  //       final match = regex.firstMatch(extractedText);
  //       if (match != null) {
  //         return match.group(0).toString();
  //       }
  //     } catch (e) {
  //       log('Exception on filterText(): $e');
  //     }
  //   }
  //   return null;
  // }

  // void cameraSource(CameraImageRequest event, Emitter<ImageState> emit) async {
  //   final image = ImagePicker();
  //   final FilteredExtractText filteredExtractText = FilteredExtractText();
  //   try {
  //     final XFile? photo = await image.pickImage(source: ImageSource.camera);
  //     if (photo == null) {
  //       emit(ImageInitial());
  //       return;
  //     }
  //     final converted = File(photo.path);
  //     log('converted path: $converted');
  //     final InputImage inputImage = InputImage.fromFile(converted);
  //     final TextRecognizer textRecognizer = TextRecognizer(
  //       script: TextRecognitionScript.latin,
  //     );
  //     final RecognizedText recognizedText = await textRecognizer.processImage(
  //       inputImage,
  //     );
  //     var filtertext = filteredExtractText.filtertext(recognizedText.text);
  //     emit(ImageSuccess(converted, recognizedText.text, filtertext));
  //   } catch (e) {
  //     log("Exception caught:  $e");
  //     emit(ImageFailure(e.toString()));
  //   }
  // }
}
