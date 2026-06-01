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
}
