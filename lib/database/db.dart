import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  DB._();
  static final DB instance = DB._();
  static Database? _database;
  get database async {
    if (_database != null) return _database;

    return await _initDabase();
  }

  _initDabase() async {
    return await openDatabase(join(await getDatabasesPath(), 'favoritos.db'),
        version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int versao) async {
    await db.execute(_livros);
  }

  String get _livros => '''
    CREATE TABLE livros (
      id INTEGER PRIMARY KEY,
      title TEXT,
      author TEXT,
      cover_url TEXT,
      download_url TEXT
    );

''';
}
