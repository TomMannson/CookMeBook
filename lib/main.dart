import 'package:cook_me_book/pages/create/create.dart';
import 'package:cook_me_book/pages/details/recipe_details_page.dart';
import 'package:cook_me_book/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/details/:recipeId',
      builder: (context, GoRouterState state) => DetailPage(
        recipeId: int.parse(state.pathParameters["recipeId"] ?? ""),
      ),
    ),
    GoRoute(
      path: '/create',
      builder: (context, state) => const CreationPage(),
    ),
    GoRoute(
      path: '/edit/:recipeId',
      builder: (context, GoRouterState state) =>
          CreationPage(recipeId: state.pathParameters["recipeId"]),
    ),
  ],
);

class MyApp extends HookWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
