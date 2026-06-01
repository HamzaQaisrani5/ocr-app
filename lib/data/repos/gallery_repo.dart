import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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
}
