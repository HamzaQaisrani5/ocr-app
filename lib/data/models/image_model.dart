import 'dart:io';

class ImageModel {
  File? image;
  String? extractedText;
  String? filterText;
  ImageModel(this.image, [this.extractedText, this.filterText]);
}
