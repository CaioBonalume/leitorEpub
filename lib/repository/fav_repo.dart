import 'package:desafio2/database/db.dart';
import 'package:desafio2/model/escribo_model.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class FavRepo extends ChangeNotifier {
  late Database db;
  final List _favBooks = [];
  List get favBooks => _favBooks;

  FavRepo() {
    _initRepository();
  }
  _initRepository() async {
    await _getFavBooks();
  }

  _getFavBooks() async {
    db = await DB.instance.database;
  }

  saveAtFavorites(EscriboModel livro, context) async {
    db = await DB.instance.database;
    bool existe = await existefav(livro);
    if (!existe) {
      await db.insert('livros', livro.toMap());
      debugPrint('Add ao favoritos');
    } else {
      await db.delete('livros', where: 'id = ?', whereArgs: [livro.id]);
      debugPrint('Removido do favoritos');
    }
    notifyListeners();
  }

  Future<bool> existefav(EscriboModel livro) async {
    db = await DB.instance.database;
    List books =
        await db.query('livros', where: 'id = ?', whereArgs: [livro.id]);
    if (books.isNotEmpty) {
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<int> getFavoritesCount() async {
    db = await DB.instance.database;
    final count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT * FROM livros'));
    notifyListeners();
    return count!;
  }

  Future<List<EscriboModel>> getFavorites() async {
    db = await DB.instance.database;
    final List<Map<String, dynamic>> maps = await db.query('livros');
    return List.generate(maps.length, (index) {
      return EscriboModel.fromMap(maps[index]);
    });
  }

  void removeall() async {
    db = await DB.instance.database;
    await db.delete('livros');
    notifyListeners();
  }
}
