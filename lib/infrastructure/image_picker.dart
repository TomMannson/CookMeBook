import 'dart:io';

import 'package:image_picker/image_picker.dart' as PackageImagePicker;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_picker.g.dart';

class ImagePicker {
  final PackageImagePicker.ImagePicker _picker =
      new PackageImagePicker.ImagePicker();

  Future<ImageResult> loadImageFromGallery() async {
    final galleryImage =
        await _picker.pickImage(source: PackageImagePicker.ImageSource.gallery);

    if (galleryImage != null) {
      return ImageLoaded(File(galleryImage.path));
    } else {
      return ImageLoadingError();
    }
  }

  Future<ImageResult> loadImageFromCamera() async {
    final galleryImage =
        await _picker.pickImage(source: PackageImagePicker.ImageSource.camera);

    if (galleryImage != null) {
      return ImageLoaded(File(galleryImage.path));
    } else {
      return ImageLoadingError();
    }
  }
}

sealed class ImageResult {}

class ImageLoaded extends ImageResult {
  final File loadedFile;

  ImageLoaded(this.loadedFile);
}

class ImageLoadingError extends ImageResult {}

@Riverpod(keepAlive: true)
ImagePicker imagePicker(ImagePickerRef ref) {
  return ImagePicker();
}
