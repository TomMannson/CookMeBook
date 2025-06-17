import 'package:cook_me_book/feature/search/search_state.dart';
import 'package:cook_me_book/infrastructure/database.dart';
import 'package:isar/isar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recipe.g.dart';

enum RecipeCategory {
  main('Dania główne', 1),
  soup('Zupy', 2),
  salad('Sałatki', 3),
  snack('Na słono', 4),
  dessert('Na słodko', 5),
  other('Inne', 6);

  final String name;
  final int id;

  const RecipeCategory(this.name, this.id);
}

@collection
class Recipe {
  Id? id = Isar.autoIncrement;

  String name = "";
  String ingredients = "";
  String recipeSteps = "";
  String preparationTime = "";
  NutritionalInfo nutritionalInfo = NutritionalInfo();
  int servings = 1;
  int category = 1;
  String? photoPath;

  Recipe();

  Recipe copyWith({
    int? id,
    String? name,
    String? ingredients,
    String? recipeSteps,
    String? preparationTime,
    NutritionalInfo? nutritionalInfo,
    int? servings,
    int? category,
    String? photoPath,
  }) {
    return Recipe()
      ..id = id ?? this.id
      ..name = name ?? this.name
      ..ingredients = ingredients ?? this.ingredients
      ..recipeSteps = recipeSteps ?? this.recipeSteps
      ..preparationTime = preparationTime ?? this.preparationTime
      ..nutritionalInfo = nutritionalInfo ?? this.nutritionalInfo
      ..servings = servings ?? this.servings
      ..category = category ?? this.category
      ..photoPath = photoPath ?? this.photoPath;
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe().copyWith(
      name: json["title"] as String? ?? "",
      recipeSteps: json["recipe"] as String? ?? "",
      ingredients: json["ingredients"] as String? ?? "",
      preparationTime: json["time"] as String? ?? "",
    );
  }
}

@embedded
class NutritionalInfo {
  int calories = 0;
  float carbs = 0;
  float fat = 0;
  float protein = 0;

  NutritionalInfo copyWith(
      {int? calories, double? carbs, double? fat, double? protein}) {
    return NutritionalInfo()
      ..calories = calories ?? this.calories
      ..carbs = carbs ?? this.carbs
      ..fat = fat ?? this.fat
      ..protein = protein ?? this.protein;
  }
}

class RecipeRepository {
  final Isar _isar;

  RecipeRepository(this._isar);

  Future<void> create(Recipe recipe) async {
    return await _isar.writeTxn(() async {
      _isar.recipes.put(recipe);
    });
  }

  Future<void> delete(int id) async {
    return await _isar.writeTxn(() async {
      _isar.recipes.delete(id);
    });
  }

  Future<List<Recipe>> findWith(String filter, RecipeCategory? category) async {
    var queryBuilder =
        _isar.recipes.filter().nameContains(filter, caseSensitive: false);

    if (category != null) {
      queryBuilder = queryBuilder
          .categoryEqualTo(RecipeCategory.values.indexOf(category) + 1);
    }

    return queryBuilder.build().findAll();
  }

  Future<Recipe?> findOneByName(int id) async {
    return await _isar.recipes.get(id);
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
  final search = await ref
      .watch(searchStateProvider.future); //TODO move to different place
  return await repo.findWith(filter, search.category);
}
