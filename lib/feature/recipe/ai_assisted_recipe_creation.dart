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
      return AiActionPicker(
        menuEnabled: !progressState.inProgress,
        onItemSelected: (value) {
          final recipeExtractor =
              ref.read(recipeExtractionStateProvider.notifier);
          if (value == AiMenuItem.web) {
            _displayTextInputDialog(context, onTextSelected: (value) {
              recipeExtractor.startRecipeWebExtraction(value);
            });
          } else {
            recipeExtractor.startRecipeExtraction(value);
          }
        },
      );
    } else {
      return const CircularProgressIndicator();
    }
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
