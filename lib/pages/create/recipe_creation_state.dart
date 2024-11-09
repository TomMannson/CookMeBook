import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/pages/create/recipe_cache_notifier.dart';
import 'package:isar/isar.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_creation_state.freezed.dart';
part 'recipe_creation_state.g.dart';

@freezed
class RecipeCreation with _$RecipeCreation {
  const factory RecipeCreation({
    required bool creationInProgress,
  }) = _RecipeCreation;
}

@riverpod
class RecipeCreationState extends _$RecipeCreationState {
  @override
  RecipeCreation build() {
    return const RecipeCreation(creationInProgress: false);
  }

  Future<void> create(Recipe recipe) async {
    state = state.copyWith(creationInProgress: true);
    try {
      var repo = await ref.read(recipeRepositoryProvider.future);
      await repo.create(recipe);
      if (recipe.id != Isar.autoIncrement) {
        ref
            .read(recipeCacheNotifierStateProvider.notifier)
            .notifyEditted(recipe);
      } else {
        ref
            .read(recipeCacheNotifierStateProvider.notifier)
            .notifyCreated(recipe);
      }
    } finally {
      state = state.copyWith(creationInProgress: false);
    }
  }
}

class RecipeLoaded {
  Recipe? _recipe;

  RecipeLoaded(this._recipe);

  Recipe? get recipe => _recipe;
}

@riverpod
Future<RecipeLoaded> recipeLoaded(RecipeLoadedRef ref, String? id) async {
  if (id == null) {
    return RecipeLoaded(null);
  }
  final repository = await ref.read(recipeRepositoryProvider.future);
  return RecipeLoaded(await repository.findOneByName(int.parse(id)));
}
