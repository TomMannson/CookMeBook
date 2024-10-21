import 'package:cook_me_book/components/navigation/app_nav_logo.dart';
import 'package:flutter/material.dart';

import 'app_nav_menu.dart';


class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Column(
        children: [
          IntrinsicWidth(
            stepWidth: double.infinity,
            child: Column(
              children: [
                AppNavLogo(),
                AppNavMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
