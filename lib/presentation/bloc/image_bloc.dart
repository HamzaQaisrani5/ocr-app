import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_app/data/models/image_model.dart';
import 'package:ocr_app/data/repos/camera_repo.dart';
import 'package:ocr_app/data/repos/extract_text.dart';
import 'package:ocr_app/data/repos/filtered_extract_text.dart';
import 'package:ocr_app/data/repos/gallery_repo.dart';
part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final GalleryRepo galleryRepo;
  final CameraRepo cameraRepo;
  final ExtractText extractText;
  ImageBloc(
    this.cameraRepo,
    this.galleryRepo,
    this.extractText,
  ) : super(ImageInitial()) {
    on<CameraImageRequest>((event, emit) async {
      try {
        final captureImage = await cameraRepo.captureImage();
        emit(ImageLoading());
        if (captureImage != null) {
          final extractedText = await extractText.extractedText(captureImage);
          final filteredText = extractText.filtertext(extractedText);
          final data = ImageModel(captureImage, extractedText, filteredText);
          emit(ImageSuccess(data));
        } else {
          emit(ImageInitial());
        }
      } catch (e) {
        emit(ImageFailure(e.toString()));
      }
    });

    on<GalleryImageRequest>((event, emit) async {
      try {
        final galleryImage = await galleryRepo.galleryImage();
        emit(ImageLoading());
        if (galleryImage != null) {
          final extractedText = await extractText.extractedText(galleryImage);
          final filterText = extractText.filtertext(extractedText);
          final data = ImageModel(galleryImage, extractedText, filterText);
          emit(ImageSuccess(data));
        } else {
          emit(ImageInitial());
        }
      } catch (e) {
        emit(ImageFailure(e.toString()));
      }
    });
  }
}
