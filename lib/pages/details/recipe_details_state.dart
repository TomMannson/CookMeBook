import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/pages/create/recipe_cache_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_details_state.g.dart';

class SelectedRecipeId {
  final int _id;

  SelectedRecipeId(this._id);

  int get id => _id;
}

class RecipeDetails {
  final Recipe? _recipe;
  final SelectedRecipeId? _selectedRecipeId;
  final bool _removed;

  RecipeDetails(this._recipe, this._selectedRecipeId, this._removed);

  Recipe? get recipe => _recipe;
  int? get selectedRecipeId => _selectedRecipeId?.id;

  RecipeDetails copyWith({
    Recipe? recipe,
    SelectedRecipeId? selectedRecipeId,
    bool? removed,
  }) {
    return RecipeDetails(
      recipe ?? _recipe,
      selectedRecipeId ?? _selectedRecipeId,
      removed ?? _removed,
    );
  }
}

@riverpod
class RecipeDetailsState extends _$RecipeDetailsState {
  void selectRecipe(int id) async {
    state = const AsyncValue.loading();

    try {
      final repository = await ref.read(recipeRepositoryProvider.future);
      final foundRecipe = await repository.findOneByName(id);

      state = AsyncValue.data(RecipeDetails(
        foundRecipe,
        SelectedRecipeId(id),
        false,
      ));
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  @override
  Future<RecipeDetails> build() async {
    ref.listen(recipeCacheNotifierStateProvider, (previous, next) async {
      if (next is RecipeDeleted && state.value?.selectedRecipeId == next.id) {
        state = AsyncData(
          RecipeDetails(
            null,
            SelectedRecipeId(next.id),
            true,
          ),
        );
      } else if (next is RecipeEditted &&
          state.value?.selectedRecipeId == next.id) {
        final repository = await ref.read(recipeRepositoryProvider.future);
        final foundRecipe = await repository.findOneByName(next.id);

        state = AsyncData(
          RecipeDetails(
            foundRecipe,
            SelectedRecipeId(next.id),
            false,
          ),
        );
      }
    });

    return RecipeDetails(null, null, false);
  }
}
