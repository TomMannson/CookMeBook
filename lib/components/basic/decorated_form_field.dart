import 'package:cook_me_book/components/style/input_style.dart';
import 'package:cook_me_book/pages/create/progress/progress_controller.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DecoratedFormField extends HookConsumerWidget {
  final TextEditingController controller;
  final String? hintText;

  const DecoratedFormField({
    super.key,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final progressState = ref.watch(progressControllerProvider);

    return TextField(
      decoration: inputDecoration(
        hintText: hintText,
      ),
      enabled: !progressState.inProgress,
      controller: controller,
    );
  }
}
