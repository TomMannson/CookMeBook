import 'package:cook_me_book/pages/create/form_state.dart';
import 'package:cook_me_book/pages/create/recipe_creation_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'use_save_action.g.dart';

typedef RecipeSaveHandler = Future<void> Function();

RecipeSaveHandler useRecipeSave({
  required RecipeForm form,
  required WidgetRef ref,
  required BuildContext context,
  String? recipeId,
}) {
  return useCallback(
    () async {
      try {
        final recipe =
            form.toRecipe().copyWith(id: int.tryParse(recipeId ?? ""));
        ref.read(recipeCreationStateProvider.notifier).create(recipe);
      } catch (e) {
        print("Error saving recipe: $e");
      }
    },
    [form, context, recipeId],
  );
}

@riverpod
RecipeSaveHandler recipeSaveHandler(RecipeSaveHandlerRef ref) {
  throw Error();
}
