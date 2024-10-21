import 'package:cook_me_book/infrastructure/database.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe.g.dart';

@collection
class Recipe {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? name;
}

class RecipeRepository {
  Isar _isar;

  RecipeRepository(this._isar);

  // Future<void> create(Recipe recipe) async {
  //   await _isar.recipes.put(recipe);
  // }

  Future<void> create(String recipe) async {
    return await _isar.writeTxn(() async {
      _isar.recipes.put(Recipe()..name = recipe);
    });
  }

  Future<List<Recipe>> findByName(String filter) async {
    return await _isar.recipes.filter().nameContains(filter).build().findAll();
  }
}

@riverpod
Future<RecipeRepository> recipeRepository(RecipeRepositoryRef ref) async {
  final isar = await ref.watch(isarBuilderProvider.future);
  return RecipeRepository(isar);
}

@riverpod
Future<List<Recipe>> foundRecipes(FoundRecipesRef ref, String filter) async {
  final repo = await ref.watch(recipeRepositoryProvider.future);
  return await repo.findByName(filter);
}
