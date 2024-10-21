import 'package:flutter/material.dart';

import '../components/navigation/app_navigationbar.dart';
import '../feature/search/app_search_bar.dart';
import '../feature/search/app_search_result.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final windowSize = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 200,
                height: windowSize.height,
                child: const AppNavigationBar(),
              ),
              const Flexible(
                child: Column(
                  children: [
                    AppSearchBar(),
                    Expanded(
                      child: AppSearchResults(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
