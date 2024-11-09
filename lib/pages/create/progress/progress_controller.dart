import 'package:cook_me_book/pages/create/recipe_creation_state.dart';
import 'package:cook_me_book/pages/create/recipe_extraction_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'progress_controller.freezed.dart';
part 'progress_controller.g.dart';

@freezed
class ProgressState with _$ProgressState {
  const factory ProgressState({
    required bool inProgress,
  }) = _ProgressState;
}

@riverpod
class ProgressController extends _$ProgressController {
  @override
  ProgressState build() {
    RecipeCreation recipeCreationState = ref.watch(recipeCreationStateProvider);
    var recipeExtractionState = ref.watch(recipeExtractionStateProvider);

    return ProgressState(
      inProgress: recipeCreationState.creationInProgress ||
          recipeExtractionState.step != ProcessSteps.idle,
    );
  }
}
