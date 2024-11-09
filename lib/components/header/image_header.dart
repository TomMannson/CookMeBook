import 'dart:io';

import 'package:cook_me_book/data/recipe.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageHeader extends StatelessWidget {
  final Recipe recipe;

  const ImageHeader(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.white,
            child: Image.file(
              File(recipe.photoPath ?? ""),
              fit: BoxFit.cover,
            ),
          ),
        ),
        IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.arrow_back))
      ],
    );
  }
}
