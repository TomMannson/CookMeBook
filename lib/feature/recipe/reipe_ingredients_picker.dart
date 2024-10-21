import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'reipe_ingredients_picker.g.dart';

@hcwidget
Widget _ingredientPicker(BuildContext context) {
  final styleTitle = Theme.of(context).textTheme.titleMedium!;
  return Container(
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Składniki", style: styleTitle),
        _Ingredient(),
      ],
    ),
  );
}

class _Ingredient extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                minLines: 6,
                maxLines: 2000,
                decoration: new InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  hintText: '',
                ),
                controller: nameController,
                onChanged: (value) {},
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        )
      ],
    );
  }
}
