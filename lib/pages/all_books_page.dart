import 'package:desafio2/repository/escribo_repo.dart';
import 'package:desafio2/shared/widgets/book_list_v.dart';
import 'package:desafio2/shared/widgets/page_titles.dart';
import 'package:flutter/material.dart';

class AllBooksPage extends StatelessWidget {
  const AllBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const PageTitleWidget(title: 'Todos os livros'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: consultarLivros(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return BookListV(livros: snapshot.data!);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
