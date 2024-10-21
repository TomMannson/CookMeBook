import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'recipe_portions_input.g.dart';

@hcwidget
Widget _recipePortoinsField(BuildContext context) {
  final style = Theme.of(context)
      .textTheme
      .titleMedium!
      .copyWith(fontWeight: FontWeight.bold);
  final nameController = useTextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Ilość porcji",
        style: style,
      ),
      SizedBox(
        height: 16,
      ),
      Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.remove),
          ),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
          IconButton(onPressed: () {}, icon: Icon(Icons.add)),
        ],
      )
    ],
  );
}
