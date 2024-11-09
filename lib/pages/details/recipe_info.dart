import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:cook_me_book/data/recipe.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/utils/custom_fonts.dart';

class RecipeInfo extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDelete;

  const RecipeInfo({
    required this.recipe,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: _RecipeInfoContent(
        recipe: recipe,
        onDelete: onDelete,
      ),
    );
  }
}

class _RecipeInfoContent extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDelete;

  const _RecipeInfoContent({
    required this.recipe,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipeNameBar(
                name: recipe.name,
                deleteAction: () => IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, size: 16),
                ),
                editAction: () => IconButton(
                  onPressed: () => context.push("/edit/${recipe.id}"),
                  icon: const Icon(CustomIcons.pen, size: 16),
                ),
              ),
              RecipeNutritions(
                nutritions: recipe.nutritionalInfo,
                time: recipe.preparationTime,
                serving: recipe.servings,
              ),
              const SizedBox(height: 32),
              _RecipeSteps(
                steps: recipe.recipeSteps,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecipeSteps extends StatelessWidget {
  final String steps;

  const _RecipeSteps({
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("Przepis"),
        const SizedBox(height: 8),
        Text(steps),
      ],
    );
  }
}

typedef WidgetFactory = Widget Function();

@immutable
class RecipeNutritions extends StatelessWidget {
  final String time;
  final int serving;
  final NutritionalInfo nutritions;

  const RecipeNutritions({
    required this.time,
    required this.serving,
    required this.nutritions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double protein = nutritions.protein;
    double carbs = nutritions.carbs;
    double fat = nutritions.fat;

    return Row(
      children: [
        MeterInfo(
          icon: Icons.access_time,
          time: time,
        ),
        MeterInfo(
          icon: Icons.access_time,
          time: "$serving porcji",
        ),
        MeterInfo(
          icon: Icons.access_time,
          time: "${nutritions.calories} kcal",
        ),
        Text("(B=$protein\g, W=$carbs\g, T=$fat\g)"),
      ],
    );
  }
}

class MeterInfo extends StatelessWidget {
  final String time;
  final IconData icon;

  const MeterInfo({
    required this.time,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(time),
        const SizedBox(width: 16)
      ],
    );
  }
}

class RecipeNameBar extends StatelessWidget {
  const RecipeNameBar(
      {super.key,
      required this.editAction,
      required this.deleteAction,
      required this.name});

  final WidgetFactory editAction;
  final WidgetFactory deleteAction;

  final String name;

  @override
  Widget build(BuildContext context) {
    final styleTitleLarge = Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(fontWeight: FontWeight.bold);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            name,
            style: styleTitleLarge,
          ),
        ),
        deleteAction(),
        editAction(),
      ],
    );
  }
}

Color getColor(int indicator) {
  if (indicator % 2 == 0) {
    return Colors.red;
  } else {
    return Colors.yellow;
  }
}
