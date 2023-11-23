import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getBooksPath() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final booksPath = '${documentsDirectory.path}/books';
  return booksPath;
}

Future<void> createBooksFolder() async {
  final booksPath = await getBooksPath();
  final booksFolder = Directory(booksPath);
  await booksFolder.create(recursive: true);
}

Future<void> saveEpubPath(String url) async {
  // Obtém o caminho da pasta books
  final booksPath = await getBooksPath();
  // Extrai o nome do arquivo do link
  final fileName = url
      .split('/')
      .last
      .replaceAll('3.images', '')
      .replaceAll('.images', '')
      .replaceAll('.noimages', '');
  // Cria o caminho do arquivo na pasta books
  final filePath = '$booksPath/$fileName';
  // Obtém uma instância das preferências compartilhadas
  final prefs = await SharedPreferences.getInstance();
  // Salva o caminho do arquivo com uma chave
  await prefs.setString('epub_path', filePath);
}

Future<bool> epubExists(String epubPath) async {
  final file = File(epubPath);
  final exists = await file.exists();
  return exists;
}

Future<String?> readEpubPath() async {
  final prefs = await SharedPreferences.getInstance();
  // Lê o caminho do arquivo com uma chave
  final filePath = prefs.getString('epub_path');
  // Retorna o caminho do arquivo ou null se não existir
  return filePath;
}

