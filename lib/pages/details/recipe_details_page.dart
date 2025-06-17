import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:cook_me_book/data/recipe.dart';
import 'package:cook_me_book/pages/create/recipe_deletion_state.dart';
import 'package:cook_me_book/pages/details/recipe_details_state.dart';
import 'package:cook_me_book/pages/details/recipe_instructions_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/header/image_header.dart';
import '../../components/navigation/mini/app_mininavigationbar.dart';

class DetailPage extends HookConsumerWidget {
  final int recipeId;

  const DetailPage({required this.recipeId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowSize = MediaQuery.sizeOf(context);
    useEffect(() {
      Future.microtask(() {
        ref.read(recipeDetailsStateProvider.notifier).selectRecipe(recipeId);
      });
      return null;
    }, [recipeId]);

    final recipeDetails = ref.watch(recipeDetailsStateProvider);
    final recipeDeletion = ref.watch(recipeDeletionStateProvider.notifier);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              NavBar(
                windowSize: windowSize,
              ),
              Expanded(
                child: recipeDetails.when(
                  data: (data) => showRecipeDetailsOrExit(
                    context,
                    data.recipe,
                    () {
                      recipeDeletion.delete(data.recipe!.id!);
                      Navigator.of(context).pop();
                    },
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (e, stack) => const Center(
                    child: Text("Error"),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget showRecipeDetailsOrExit(
  BuildContext context,
  Recipe? recipe,
  VoidCallback onDelete,
) {
  if (recipe == null) {
    return const Center(child: Text("Recipe not found"));
  }

  return LoadedRecipeDetail(
    recipe: recipe,
    onDelete: onDelete,
  );
}

class LoadedRecipeDetail extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDelete;

  const LoadedRecipeDetail({
    super.key,
    required this.recipe,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.blue.shade100,
            child: Column(
              children: [
                ImageHeader(recipe),
                _IngredientsList(recipe),
              ],
            ),
          ),
        ),
        RecipeInfo(
          recipe: recipe,
          onDelete: () {
            _showDeleteRecipeDialog(
              context,
              onDeleteConfirmed: onDelete,
            );
          },
        )
      ],
    );
  }
}

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.windowSize,
  });

  final Size windowSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 58,
      height: windowSize.height,
      child: const AppMiniNavigationBar(),
    );
  }
}

class _IngredientsList extends StatelessWidget {
  final Recipe recipe;

  const _IngredientsList(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText("Składniki"),
                const SizedBox(height: 8),
                Text(recipe.ingredients),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _showDeleteRecipeDialog(
  BuildContext context, {
  required VoidCallback onDeleteConfirmed,
}) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: const Text("Usuń przepis"),
        content: const Text(
          "Zamierzasz usunąć ten przepis. Jest to operacja nie odwracalna i nie będzie można jej cofnąć",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: onDeleteConfirmed,
            child: const Text("Remove"),
          ),
        ],
      );
    },
  );
}
