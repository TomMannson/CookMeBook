import 'package:cook_me_book/components/style/input_style.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:cook_me_book/pages/create/recipe_extraction_state.dart';

class AiAssistedTextField extends HookConsumerWidget {
  final TextEditingController controller;
  final InputDecoration? decoration;

  const AiAssistedTextField({
    super.key,
    required this.controller,
    this.decoration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeExtraction = ref.watch(recipeExtractionStateProvider.notifier);
    final progressState = ref.watch(progressControllerProvider);

    return TextField(
      contextMenuBuilder: (context, editableTextState) {
        final List<ContextMenuButtonItem> buttonItems =
            editableTextState.contextMenuButtonItems;

        buttonItems.insert(
            0,
            ContextMenuButtonItem(
              label: 'Quick Ai Camera extractor',
              onPressed: () async {
                ContextMenuController.removeAny();
                final result = await recipeExtraction.startTextExtraction();
                if (result != null) {
                  Clipboard.setData(ClipboardData(text: result));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Przetworzony text czeka. Urzyj opcji `Wklej`",
                      ),
                    ),
                  );
                }
              },
            ));

        return AdaptiveTextSelectionToolbar.buttonItems(
          anchors: editableTextState.contextMenuAnchors,
          buttonItems: buttonItems,
        );
      },
      enabled: !progressState.inProgress,
      minLines: 6,
      maxLines: 2000,
      decoration: decoration,
      controller: controller,
    );
  }
}

enum AiMenuItem { galery, camera, web }

class AiActionPicker extends StatelessWidget {
  final ValueChanged<AiMenuItem> onItemSelected;
  final bool menuEnabled;

  const AiActionPicker({
    super.key,
    required this.onItemSelected,
    required this.menuEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AiMenuItem>(
      enabled: menuEnabled,
      icon: const Icon(Icons.auto_awesome),
      onSelected: onItemSelected,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<AiMenuItem>>[
        const PopupMenuItem<AiMenuItem>(
          value: AiMenuItem.galery,
          child: ListTile(
            leading: Icon(Icons.image),
            title: Text('Galeria'),
          ),
        ),
        const PopupMenuItem<AiMenuItem>(
          value: AiMenuItem.camera,
          child: ListTile(
            leading: Icon(Icons.camera),
            title: Text('Camera'),
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<AiMenuItem>(
          value: AiMenuItem.web,
          child: ListTile(
            leading: Icon(Icons.web),
            title: Text('Get from web link'),
          ),
        ),
      ],
    );
  }
}

Future<void> _displayTextInputDialog(BuildContext context,
    {required ValueChanged<String> onTextSelected}) async {
  return showDialog(
    context: context,
    builder: (context) {
      TextEditingController _urlTextController = TextEditingController();

      return AlertDialog(
        title: const Text('Url Selection'),
        content: TextField(
          controller: _urlTextController,
          decoration: const InputDecoration(hintText: "Place url here"),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              onTextSelected(_urlTextController.text);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
