import 'package:flutter/material.dart';

class FavIconActive extends StatelessWidget {
  const FavIconActive({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.bookmark,
        size: 30, color: Theme.of(context).colorScheme.onPrimaryContainer);
  }
}

class FavIconDesactive extends StatelessWidget {
  const FavIconDesactive({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.bookmark_outline,
        size: 30, color: Theme.of(context).colorScheme.onPrimaryContainer);
  }
}
