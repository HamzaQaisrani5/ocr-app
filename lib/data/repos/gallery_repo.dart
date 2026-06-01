import 'dart:developer';
import 'dart:io';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:ocr_app/data/repos/filtered_extract_text.dart';
// import 'package:ocr_app/presentation/bloc/image_bloc.dart';

class GalleryRepo {
  Future<File?> galleryImage() async {
    final ImagePicker imagePicker = ImagePicker();
    try {
      final XFile? photo = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (photo != null) {
        final imageFile = File(photo.path);
        return imageFile;
      }
      return null;
    } catch (e) {
      log('Exception on galleryImage(): $e');
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
  //     log('Exception of gallerySourceExtractedtext(): $e');
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
  //       return null;
  //     } catch (e) {
  //       log('Exception on gallerySourcefilterText(): $e');
  //     }
  //   }
  //   return null;
  // }

  // Future<void> gallerySource(
  //   GalleryImageRequest event,
  //   Emitter<ImageState> emit,
  // ) async {
  //   final image = ImagePicker();
  //   final FilteredExtractText filteredExtractText = FilteredExtractText();

  //   try {
  //     final XFile? photo = await image.pickImage(source: ImageSource.gallery);
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
