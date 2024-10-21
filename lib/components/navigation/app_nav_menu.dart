import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const _menuItemTexts = [
  "Wszystkie",
  "Dania główne",
  "Zupy",
  "Sałatki",
  "Przekąski",
  "Ciasta",
];

class AppNavMenu extends HookWidget {
  const AppNavMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);

    return Material(
      color: Colors.transparent,
      child: Column(children: [
        for (int i = 0; i < 5; i++)
          _NavItem(
            _menuItemTexts[i],
            i == selectedIndex.value,
            () {
              selectedIndex.value = i;
            },
          )
      ]),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String _text;
  final bool _selected;
  final VoidCallback onSelected;

  const _NavItem(this._text, this._selected, this.onSelected, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: ListTile(
        minTileHeight: 48,
        selected: _selected,
        selectedTileColor: Colors.amber,
        title: Text(
          _text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
