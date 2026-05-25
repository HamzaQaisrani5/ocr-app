part of 'image_bloc.dart';

@immutable
sealed class ImageEvent {}

class CameraImageRequest extends ImageEvent{}

class GalleryImageRequest extends ImageEvent{}
