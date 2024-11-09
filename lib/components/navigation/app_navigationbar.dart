import 'package:cook_me_book/components/navigation/app_nav_logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    CreateButton(),
                  ],
                ),
                AppNavMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0, left: 8.0, right: 8.0),
      child: FloatingActionButton.extended(
        onPressed: () {
          context.push("/create");
        },
        backgroundColor: Colors.amber,
        label: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Create",
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              width: 72,
            )
          ],
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
