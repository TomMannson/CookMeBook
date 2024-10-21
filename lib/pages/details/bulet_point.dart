import 'package:flutter/material.dart';

import '../../components/utils/custom_fonts.dart';

class BulletPointItem extends StatelessWidget {
  final String ingredientName;
  final int? number;

  const BulletPointItem({
    required this.ingredientName,
    this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (number == null)
              Padding(
                padding: const EdgeInsets.only(top: 6.0, left: 8.0),
                child: Icon(
                  CustomIcons.primitive_dot,
                  size: 8,
                ),
              ),

            if(number != null)
              Text(
                "$number",
                softWrap: true,
              ),

            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                ingredientName,
                softWrap: true,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}