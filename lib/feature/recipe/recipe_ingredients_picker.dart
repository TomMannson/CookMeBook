import 'package:cook_me_book/components/basic/title_text.dart';
import 'package:cook_me_book/components/style/input_style.dart';
import 'package:cook_me_book/feature/recipe/ai_assisted_textfield.dart';
import 'package:cook_me_book/infrastructure/ai_recipe_formatter.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:cook_me_book/pages/create/recipe_extraction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IngredientPicker extends HookConsumerWidget {
  final TextEditingController ingredientsSection;

  const IngredientPicker(this.ingredientsSection, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);
    final recipeExtraction = ref.watch(recipeExtractionStateProvider.notifier);
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
                    child: AiAssistedTextField(
                      controller: ingredientsSection,
                    ),
                    // child: TextField(
                    //   contextMenuBuilder: (context, editableTextState) {
                    //     final List<ContextMenuButtonItem> buttonItems =
                    //         editableTextState.contextMenuButtonItems;

                    //     buttonItems.insert(
                    //         0,
                    //         ContextMenuButtonItem(
                    //           label: 'Quick Ai Camera extractor',
                    //           onPressed: () async {
                    //             ContextMenuController.removeAny();
                    //             final result = await recipeExtraction
                    //                 .startTextExtraction();
                    //             if (result != null) {
                    //               Clipboard.setData(
                    //                   ClipboardData(text: result));
                    //             } else {
                    //               ScaffoldMessenger.of(context).showSnackBar(
                    //                 const SnackBar(
                    //                   content: Text(
                    //                     "Przetworzony text czeka. Urzyj opcji `Wklej`",
                    //                   ),
                    //                 ),
                    //               );
                    //             }
                    //           },
                    //         ));

                    //     return AdaptiveTextSelectionToolbar.buttonItems(
                    //       anchors: editableTextState.contextMenuAnchors,
                    //       buttonItems: buttonItems,
                    //     );
                    //   },
                    //   enabled: !progressState.inProgress,
                    //   minLines: 6,
                    //   maxLines: 2000,
                    //   decoration: inputDecoration(),
                    //   controller: ingredientsSection,
                    // ),
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
