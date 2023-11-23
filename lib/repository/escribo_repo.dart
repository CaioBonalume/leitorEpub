import 'dart:convert';
import 'dart:io';

import 'package:desafio2/model/escribo_model.dart';
import 'package:desafio2/shared/widgets/book_saver/get_book.dart';
import 'package:http/http.dart' as http;

Future<List<EscriboModel>> consultarLivros() async {
  const url = "https://escribo.com/books.json";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final livros = EscriboModel.fromJsonList(data);
    return livros;
  } else {
    throw Exception('Falha ao carregar os livros');
  }
}

Future<void> downloadEpub(String url) async {
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final booksPath = await getBooksPath();
    final fileName = url
        .split('/')
        .last
        .replaceAll('3.images', '')
        .replaceAll('.images', '')
        .replaceAll('.noimages', '');
    final filePath = '$booksPath/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
  } else {
    throw Exception('Falha ao baixar o livro');
  }
}
