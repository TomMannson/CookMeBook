import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:cook_me_book/components/style/input_style.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngredientPicker extends HookConsumerWidget {
  final TextEditingController ingredientsSection;

  const IngredientPicker(this.ingredientsSection, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText("Składniki"),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      enabled: !progressState.inProgress,
                      minLines: 6,
                      maxLines: 2000,
                      decoration: inputDecoration(),
                      controller: ingredientsSection,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ],
      ),
    );
  }
}
