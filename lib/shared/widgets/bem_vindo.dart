import 'package:flutter/material.dart';

class BemVindoWidget extends StatelessWidget {
  const BemVindoWidget({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bem-Vindo, $name',
      style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.onBackground),
    );
  }
}
