import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cook_me_book/pages/create/recipe_extraction_state.dart';

class AiAssistedRecipeCreation extends HookConsumerWidget {
  const AiAssistedRecipeCreation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(recipeExtractionStateProvider).step;
    final progressState = ref.watch(progressControllerProvider);

    if (step == ProcessSteps.idle) {
      return IconButton(
        onPressed: progressState.inProgress
            ? null
            : () async {
                ref
                    .read(recipeExtractionStateProvider.notifier)
                    .startRecipeExtraction();
              },
        icon: const Icon(Icons.auto_awesome),
      );
    } else {
      return const CircularProgressIndicator();
    }
  }
}
