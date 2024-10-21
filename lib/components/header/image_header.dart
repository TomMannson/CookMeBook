import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImageHeader extends StatelessWidget {
  const ImageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            color: Colors.white,
            child: Placeholder(),
          ),
        ),
        IconButton(
            onPressed: context.pop,
            icon: Icon(Icons.arrow_back))
      ],
    );
  }
}