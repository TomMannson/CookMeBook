import 'dart:developer';

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
    final styleTitleLarge = Theme.of(context)
        .textTheme
        .headlineMedium!
        .copyWith(fontWeight: FontWeight.bold);

    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecipeNameBar(
                      name: this.recipe.name,
                      styleTitleLarge: styleTitleLarge,
                      deleteAction: () {
                        return IconButton(
                          onPressed: onDelete,
                          icon: const Icon(
                            Icons.delete,
                            size: 16,
                          ),
                        );
                      },
                      editAction: () {
                        return IconButton(
                          onPressed: () {
                            context.push("/edit/${recipe.id}");
                          },
                          icon: const Icon(
                            CustomIcons.pen,
                            size: 16,
                          ),
                        );
                        ;
                      },
                    ),
                    RecipeNutritions(
                      nutritionalInfo: recipe.nutritionalInfo,
                      time: recipe.preparationTime,
                      serving: recipe.servings,
                    ),
                    SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleText("Przepis"),
                        const SizedBox(height: 8),
                        Text(recipe.recipeSteps),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef WidgetFactory = Widget Function();

class RecipeNutritions extends StatelessWidget {
  final String time;
  final int serving;
  final NutritionalInfo nutritionalInfo;

  const RecipeNutritions({
    required this.time,
    required this.serving,
    required this.nutritionalInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double protein = nutritionalInfo.protein;
    double carbs = nutritionalInfo.carbs;
    double fat = nutritionalInfo.fat;

    String timeText = time.trim().isEmpty ? "0" : time;

    return Row(
      children: [
        _MeterInfo(
          value: "$timeText dni",
          icon: Icons.access_time,
        ),
        _MeterInfo(
          value: "$serving porcji",
          icon: Icons.access_time,
        ),
        _MeterInfo(
          value: "${nutritionalInfo.calories} kcal",
          icon: Icons.access_time,
        ),
        Text("(B=$protein\g, W=$carbs\g, T=$fat\g)"),
      ],
    );
  }
}

class _MeterInfo extends StatelessWidget {
  final String value;
  final IconData icon;

  const _MeterInfo({
    required this.value,
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
        Text(value),
        const SizedBox(width: 16),
      ],
    );
  }
}

class RecipeNameBar extends StatelessWidget {
  const RecipeNameBar(
      {super.key,
      required this.styleTitleLarge,
      required this.editAction,
      required this.deleteAction,
      required this.name});

  final TextStyle styleTitleLarge;
  final WidgetFactory editAction;
  final WidgetFactory deleteAction;

  final String name;

  @override
  Widget build(BuildContext context) {
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
