import 'dart:developer';

import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/infrastructure/ai_recipe_formatter.dart';
import 'package:cook_me_book/infrastructure/image_picker.dart';
import 'package:cook_me_book/infrastructure/text_extractor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_extraction_state.g.dart';

class ExtractionProcess {
  ProcessSteps _step = ProcessSteps.idle;
  Recipe? _extractedRecipe;

  ProcessSteps get step => _step;

  Recipe? get extractedRecipe => _extractedRecipe;

  ExtractionProcess copyWith({ProcessSteps? step, Recipe? extractedRecipe}) {
    return ExtractionProcess()
      .._step = step ?? _step
      .._extractedRecipe = extractedRecipe ?? _extractedRecipe;
  }
}

enum ProcessSteps { idle, imageToText, recipeExtraction }

@riverpod
class RecipeExtractionState extends _$RecipeExtractionState {
  late ImagePicker imagePicker;
  late TextExtractor textExtractor;
  late AiFormater aiFormater;

  @override
  ExtractionProcess build() {
    imagePicker = ref.read(imagePickerProvider);
    textExtractor = ref.read(textExtractorProvider);
    aiFormater = ref.read(aiFormaterProvider);
    return ExtractionProcess();
  }

  void startRecipeExtraction() async {
    state = state.copyWith(step: ProcessSteps.imageToText);
    final imageLoadingResult = await imagePicker.loadImageFromGallery();

    if (imageLoadingResult is ImageLoaded) {
      ImageLoaded loadedImafge = imageLoadingResult;
      final extractedText =
          await textExtractor.extractTextFromImageFile(loadedImafge.loadedFile);
      log("Text of recipe extracted");
      state = state.copyWith(step: ProcessSteps.recipeExtraction);
      try {
        final recipe = await aiFormater.formatRecipeInText(extractedText);

        log("Recipe extracted");

        state =
            state.copyWith(step: ProcessSteps.idle, extractedRecipe: recipe);
        return;
      } catch (e) {
        log("Error $e while recipe extraction");
      }
    } else {
      log("Image wasn't selected");
    }

    state = state.copyWith(step: ProcessSteps.idle, extractedRecipe: null);
  }
}
