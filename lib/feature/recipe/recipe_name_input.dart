import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'recipe_name_input.g.dart';

@hcwidget
Widget _recipeNameInput(BuildContext context) {
  final style = Theme.of(context)
      .textTheme
      .titleMedium!
      .copyWith(fontWeight: FontWeight.bold);
  final nameController = useTextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Co przyrządzamy",
        style: style,
      ),
      TextField(
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
      )
    ],
  );
}
