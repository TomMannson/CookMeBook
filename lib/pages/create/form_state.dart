import 'package:cook_me_book/data/recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_state.g.dart';

class RecipeForm {
  final TextEditingController titleController;
  final TextEditingController servingsSection;
  final TextEditingController preparationTimeController;
  final RecipeNutritionsFormSection nutritionsFormSection;
  final ValueNotifier<int> selectedCategoryNotifier;
  final ValueNotifier<String?> imagePathNotifier;
  final TextEditingController recipeStepsController;
  final TextEditingController ingredientListController;

  RecipeForm({
    required this.titleController,
    required this.servingsSection,
    required this.preparationTimeController,
    required this.nutritionsFormSection,
    required this.selectedCategoryNotifier,
    required this.imagePathNotifier,
    required this.recipeStepsController,
    required this.ingredientListController,
  });

  Recipe toRecipe() {
    return Recipe().copyWith(
      name: titleController.text,
      servings: int.parse(servingsSection.text),
      preparationTime: preparationTimeController.text,
      nutritionalInfo: nutritionsFormSection.toNutritionsInfo(),
      category: selectedCategoryNotifier.value,
      photoPath: imagePathNotifier.value,
      recipeSteps: recipeStepsController.text,
      ingredients: ingredientListController.text,
    );
  }
}

class RecipeNutritionsFormSection {
  final TextEditingController caloriesController;
  final TextEditingController proteinsController;
  final TextEditingController carbsController;
  final TextEditingController fatsController;

  RecipeNutritionsFormSection({
    required this.caloriesController,
    required this.proteinsController,
    required this.carbsController,
    required this.fatsController,
  });

  NutritionalInfo toNutritionsInfo() {
    return NutritionalInfo().copyWith(
      calories: int.tryParse(caloriesController.text) ?? 0,
      protein: double.tryParse(proteinsController.text) ?? 0,
      carbs: double.tryParse(carbsController.text) ?? 0,
      fat: double.tryParse(fatsController.text) ?? 0,
    );
  }
}

class RecipeImageFormSection {}

RecipeForm useRecipeForm(Recipe? initialRecipe) {
  return RecipeForm(
    titleController:
        useTwoWaySyncTextFieldSection(initialValue: initialRecipe?.name ?? ''),
    servingsSection: useTwoWaySyncTextFieldSection(
        initialValue: initialRecipe?.servings.toString() ?? ''),
    preparationTimeController: useTwoWaySyncTextFieldSection(
        initialValue: initialRecipe?.preparationTime ?? ''),
    nutritionsFormSection: useRecipeNutritionsFormSection(
        nutritionsInfo: initialRecipe?.nutritionalInfo),
    selectedCategoryNotifier:
        useTwoWaySyncValueNotifier(initialRecipe?.category ?? 0),
    imagePathNotifier: useTwoWaySyncValueNotifier(initialRecipe?.photoPath),
    recipeStepsController: useTwoWaySyncTextFieldSection(
        initialValue: initialRecipe?.recipeSteps ?? ''),
    ingredientListController: useTwoWaySyncTextFieldSection(
        initialValue: initialRecipe?.ingredients ?? ''),
  );
}

ValueNotifier<T> useTwoWaySyncValueNotifier<T>(T initialValue) {
  final value = useState(initialValue);

  useEffect(() {
    if (value.value != initialValue) {
      value.value = initialValue;
    }
    return null;
  }, [initialValue]);

  return value;
}

RecipeNutritionsFormSection useRecipeNutritionsFormSection(
    {NutritionalInfo? nutritionsInfo}) {
  final caloriesSection = useTwoWaySyncTextFieldSection(
    initialValue: nutritionsInfo?.calories.toString() ?? '',
  );
  final proteinsSection = useTwoWaySyncTextFieldSection(
    initialValue: nutritionsInfo?.protein.toString() ?? '',
  );
  final fatsSection = useTwoWaySyncTextFieldSection(
    initialValue: nutritionsInfo?.fat.toString() ?? '',
  );
  final carbohydratesSection = useTwoWaySyncTextFieldSection(
    initialValue: nutritionsInfo?.carbs.toString() ?? '',
  );

  return useMemoized(() {
    return RecipeNutritionsFormSection(
      caloriesController: caloriesSection,
      proteinsController: proteinsSection,
      fatsController: fatsSection,
      carbsController: carbohydratesSection,
    );
  }, [caloriesSection, proteinsSection, fatsSection, carbohydratesSection]);
}

TextEditingController useTwoWaySyncTextFieldSection(
    {required String initialValue}) {
  final controller = useTextEditingController(text: initialValue);

  useEffect(() {
    if (controller.text != initialValue) {
      controller.text = initialValue;
    }
  }, [initialValue]);

  return controller;
}

@riverpod
RecipeForm recipeForm(RecipeFormRef ref) {
  throw Error();
}
