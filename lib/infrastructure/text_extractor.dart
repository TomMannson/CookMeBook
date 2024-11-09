import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart' as image_to_text;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'text_extractor.g.dart';

class TextExtractor {
  final image_to_text.TextRecognizer _recognizer =
      new image_to_text.TextRecognizer();

  Future<String> extractTextFromImageFile(File file) async {
    final inputImage = image_to_text.InputImage.fromFile(file);
    final extractionResult = await _recognizer.processImage(inputImage);
    return extractionResult.text;
  }
}

@Riverpod(keepAlive: true)
TextExtractor textExtractor(TextExtractorRef ref) {
  return TextExtractor();
}
