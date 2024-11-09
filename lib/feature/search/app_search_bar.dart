import 'package:cook_me_book/feature/search/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppSearchBar extends HookConsumerWidget {
  const AppSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textEditing = useTextEditingController();

    useMemoized(() => ref.read(searchStateProvider.notifier).search(""));

    textEditing.addListener(() {
      ref.read(searchStateProvider.notifier).search(textEditing.text);
    });

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SearchBar(
          hintText: "Search",
          elevation: const WidgetStatePropertyAll(1),
          overlayColor: const WidgetStatePropertyAll(Colors.blue),
          // shadowColor:  const WidgetStatePropertyAll(Colors.red),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.blue),
          controller: textEditing,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 15),
          ),
          leading: const Icon(Icons.search),
        ),
      ),
    );
  }
}
