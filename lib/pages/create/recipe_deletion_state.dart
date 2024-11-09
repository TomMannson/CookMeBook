import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/pages/create/recipe_cache_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_deletion_state.g.dart';

@riverpod
class RecipeDeletionState extends _$RecipeDeletionState {
  @override
  Recipe build() {
    return Recipe();
  }

  Future<void> delete(int id) async {
    var repo = await ref.read(recipeRepositoryProvider.future);
    repo.delete(id);
    ref.read(recipeCacheNotifierStateProvider.notifier).notifyDeleted(id);
  }
}
