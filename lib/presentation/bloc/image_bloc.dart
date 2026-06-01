// import 'dart:async';
// import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocr_app/data/repos/camera_repo.dart';
import 'package:ocr_app/data/repos/gallery_repo.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:ocr_app/data/repos.dart';
part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final CameraRepo cameraRepo;
  final GalleryRepo galleryRepo;
  ImageBloc(this.cameraRepo, this.galleryRepo) : super(ImageInitial()) {
    on<CameraImageRequest>(cameraRepo.cameraSource);

    on<GalleryImageRequest>(galleryRepo.gallerySource);
  }
}
