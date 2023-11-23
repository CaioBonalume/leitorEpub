import 'dart:convert';

import 'package:desafio2/model/escribo_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider extends ChangeNotifier {
  List<EscriboModel> _books = [];
  List<EscriboModel> get books => _books;

  void toggleFavorite(EscriboModel epub) {
    final isExist = _books.contains(epub);
    if (isExist) {
      _books.remove(epub);
    } else {
      _books.add(epub);
    }
    notifyListeners();
  }

  bool isFav(EscriboModel epub) {
    final isExist = _books.contains(epub);
    return isExist;
  }

  void clearFavorite() {
    _books = [];
    notifyListeners();
  }

  void saveFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    // Converte a lista de favoritos em uma lista de mapas
    List<Map<String, dynamic>> favoritosMap =
        _books.map((epub) => epub.toMap()).toList();
    // Converte a lista de mapas em uma string JSON
    String favoritosJson = jsonEncode(favoritosMap);
    // Salva a string JSON no SharedPreferences com a chave 'favoritos'
    prefs.setString('books', favoritosJson);
  }

  void restoreFavorito() async {
    final prefs = await SharedPreferences.getInstance();
    // Obtém a string JSON do SharedPreferences com a chave 'favoritos'
    String? favoritosJson = prefs.getString('books');
    if (favoritosJson != null) {
      // Converte a string JSON em uma lista de mapas
      List<Map<String, dynamic>> favoritosMap =
          jsonDecode(favoritosJson).cast<Map<String, dynamic>>();
      // Converte a lista de mapas em uma lista de objetos
      List<EscriboModel> favoritosEpub =
          favoritosMap.map((map) => EscriboModel.fromMap(map)).toList();
      // Atualiza a lista de favoritos com a lista de objetos
      _books = favoritosEpub;
      notifyListeners();
    }
  }
}
