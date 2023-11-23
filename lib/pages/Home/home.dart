import 'package:desafio2/pages/Home/book_page.dart';
import 'package:desafio2/pages/Favorites/fav_page.dart';

import 'package:desafio2/shared/widgets/bem_vindo.dart';
import 'package:flutter/material.dart';


enum TypeBook { livros, fav }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

TypeBook typeBook = TypeBook.livros;
int indexBookPage = 0;
final List<bool> _selectedOptions = <bool>[true, false];

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const BemVindoWidget(name: 'Visitante'),
          const SizedBox(height: 10),
          ToggleButtons(
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedOptions.length; i++) {
                    _selectedOptions[i] = i == index;
                    indexBookPage = index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedOptions,
              children: const [Text('Livros'), Text('Favoritos')]),
          const SizedBox(height: 10),
          indexBookPage == 0 ? const BookPage() : const FavPage()
        ]),
      ),
    );
  }
}
