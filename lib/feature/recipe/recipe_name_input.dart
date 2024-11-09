import 'package:cook_me_book/components/basic/decorated_form_field.dart';
import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'ai_assisted_recipe_creation.dart';

class RecipeTitleField extends HookConsumerWidget {
  final TextEditingController titleController;

  const RecipeTitleField(this.titleController, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleText("Co przyżądzamy"),
        Row(
          children: [
            Expanded(
              child: DecoratedFormField(
                controller: titleController,
              ),
            ),
            const SizedBox(width: 8),
            const AiAssistedRecipeCreation(),
          ],
        )
      ],
    );
  }
}
