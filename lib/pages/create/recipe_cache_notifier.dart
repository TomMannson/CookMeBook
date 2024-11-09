import 'package:cook_me_book/data/recipe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe_cache_notifier.g.dart';

sealed class RecipeCacheNotifierEvent {}

class RecipeCreated extends RecipeCacheNotifierEvent {
  final int id;

  RecipeCreated(this.id);
}

class RecipeEditted extends RecipeCacheNotifierEvent {
  final int id;

  RecipeEditted(this.id);
}

class RecipeDeleted extends RecipeCacheNotifierEvent {
  final int id;

  RecipeDeleted(this.id);
}

@riverpod
class RecipeCacheNotifierState extends _$RecipeCacheNotifierState {
  @override
  RecipeCacheNotifierEvent? build() {
    return null;
  }

  void notifyCreated(Recipe recipe) {
    state = RecipeCreated(recipe.id!);
  }

  void notifyEditted(Recipe recipe) {
    state = RecipeEditted(recipe.id!);
  }

  void notifyDeleted(int id) {
    state = RecipeDeleted(id);
  }
}
