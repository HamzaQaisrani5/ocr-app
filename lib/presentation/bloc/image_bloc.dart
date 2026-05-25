import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc() : super(ImageInitial()) {
    on<CameraImageRequest>(cameraSource);

    on<GalleryImageRequest>(gallerySource);
  }

  void cameraSource(CameraImageRequest event, Emitter<ImageState> emit) async {
    final image = ImagePicker();
    try {
      // emit(ImageLoading());
      final XFile? photo = await image.pickImage(source: ImageSource.camera);
      if (photo == null) {
        emit(ImageInitial());
        return;
      }
      final converted = File(photo.path);
      log('converted path: $converted');
      final InputImage inputImage = InputImage.fromFile(converted);
      final TextRecognizer textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      emit(ImageSuccess(converted, recognizedText.text));
    } catch (e) {
      log("Exception caught:  $e");
      emit(ImageFailure(e.toString()));
    }
  }

  Future<void> gallerySource(
    GalleryImageRequest event,
    Emitter<ImageState> emit,
  ) async {
    final image = ImagePicker();
    try {
      final XFile? photo = await image.pickImage(source: ImageSource.gallery);
      if (photo == null) {
        emit(ImageInitial());
        return;
      }
      final converted = File(photo.path);
      log('converted path: $converted');
      final InputImage inputImage = InputImage.fromFile(converted);
      final TextRecognizer textRecognizer = TextRecognizer(
        script: TextRecognitionScript.latin,
      );
      final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
      emit(ImageSuccess(converted, recognizedText.text));
    } catch (e) {
      log("Exception caught:  $e");
      emit(ImageFailure(e.toString()));
    }
  }
}
