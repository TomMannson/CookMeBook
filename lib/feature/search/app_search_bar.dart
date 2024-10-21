import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppSearchBar extends HookWidget {
  const AppSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textEditting = useTextEditingController();

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SearchBar(
          hintText: "Search",
          elevation: const WidgetStatePropertyAll(1),
          // backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
          overlayColor: const WidgetStatePropertyAll(Colors.blue),
          // shadowColor:  const WidgetStatePropertyAll(Colors.red),
          surfaceTintColor: const WidgetStatePropertyAll(Colors.blue),
          controller: textEditting,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 15),
          ),
          leading: const Icon(Icons.search),
        ),
      ),
    );
  }
}