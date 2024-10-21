import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'recipe_nutrition_picker.g.dart';

@hcwidget
Widget _recipeNutritionPicker(BuildContext context) {
  final style = Theme.of(context)
      .textTheme
      .titleMedium!
      .copyWith(fontWeight: FontWeight.bold);
  final nameController = useTextEditingController();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Wartości odżywcze",
        style: style,
      ),
      Text(
        "odpowiadające jednej porcji",
      ),
      SizedBox(height: 16),
      Row(
        children: [
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: new InputDecoration(
                label: Text("kcal"),
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
          SizedBox(
            width: 16,
          ),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: new InputDecoration(
                label: Text("W"),
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
          SizedBox(
            width: 16,
          ),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: new InputDecoration(
                label: Text("B"),
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
          SizedBox(
            width: 16,
          ),
          SizedBox(
            width: 80,
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: new InputDecoration(
                label: Text("T"),
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
      )
    ],
  );
}
