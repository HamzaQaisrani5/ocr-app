part of 'image_bloc.dart';

@immutable
sealed class ImageState {}

final class ImageInitial extends ImageState {}

final class ImageLoading extends ImageState {}

final class ImageFailure extends ImageState {
  final String errorMsg;
  ImageFailure(this.errorMsg);
}

final class ImageSuccess extends ImageState {
  final ImageModel imageModel;
  ImageSuccess(this.imageModel);
}
