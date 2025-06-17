import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:cook_me_book/components/style/input_style.dart';
import 'package:cook_me_book/pages/create/form_state.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipeNutritionPicker extends HookConsumerWidget {
  final RecipeNutritionsFormSection nutritionsFormSection;

  const RecipeNutritionPicker(this.nutritionsFormSection, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("Wartości odżywcze"),
        const Text("odpowiadające jednej porcji"),
        const SizedBox(height: 16),
        Row(
          children: [
            NutritionalValueField(
              label: "kcal",
              textController: nutritionsFormSection.caloriesController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(width: 8),
            NutritionalValueField(
              label: "Węgle",
              textController: nutritionsFormSection.carbsController,
            ),
            const SizedBox(width: 8),
            NutritionalValueField(
              label: "Białko",
              textController: nutritionsFormSection.proteinsController,
            ),
            const SizedBox(width: 8),
            NutritionalValueField(
              label: "Tłuszcz",
              textController: nutritionsFormSection.fatsController,
            ),
          ],
        )
      ],
    );
  }
}

class NutritionalValueField extends HookConsumerWidget {
  final String label;

  final TextEditingController textController;

  final TextInputType keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  const NutritionalValueField({
    required this.label,
    required this.textController,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
        width: 90,
        child: TextField(
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          enabled: !progressState.inProgress,
          decoration: inputDecoration(
            labelText: label,
          ),
          controller: textController,
        ),
      ),
    );
  }
}
