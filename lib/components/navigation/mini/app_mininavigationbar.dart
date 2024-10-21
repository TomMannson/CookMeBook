import 'package:flutter/material.dart';

import 'app_nav_menu.dart';

class AppMiniNavigationBar extends StatelessWidget {
  const AppMiniNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppMiniNavMenu()
        ],
      ),
    );
  }
}
