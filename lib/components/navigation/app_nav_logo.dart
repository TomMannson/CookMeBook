import 'package:flutter/material.dart';

class AppNavLogo extends StatelessWidget {
  const AppNavLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      child: const Text(
        "CookMe",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
