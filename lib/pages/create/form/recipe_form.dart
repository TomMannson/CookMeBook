import 'dart:io';

import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/components/style/input_style.dart';
import 'package:cook_me_book/feature/recipe/ai_assisted_textfield.dart';
import 'package:cook_me_book/feature/recipe/recipe_name_input.dart';
import 'package:cook_me_book/feature/recipe/recipe_nutrition_picker.dart';
import 'package:cook_me_book/feature/recipe/recipe_portions_input.dart';
import 'package:cook_me_book/feature/recipe/recipe_ingredients_picker.dart';
import 'package:cook_me_book/pages/create/form_state.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

part 'category_selection.dart';

class RecipeFormWidget extends StatelessWidget {
  final RecipeForm form;

  const RecipeFormWidget({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                RecipeTitleField(form.titleController),
                const SizedBox(height: 32),
                RecipePortoinsField(
                  form.servingsSection,
                  form.preparationTimeController,
                ),
                const SizedBox(height: 32),
                RecipeNutritionPicker(form.nutritionsFormSection),
                const SizedBox(height: 32),
                _CategorySelection(form.selectedCategoryNotifier),
                const SizedBox(height: 32),
                _PicturePicker(form.imagePathNotifier)
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IngredientPicker(form.ingredientListController),
                _RecipeSteps(form.recipeStepsController),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
