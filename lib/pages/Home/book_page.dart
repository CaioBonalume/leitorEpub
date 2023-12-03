import 'package:desafio2/pages/all_books_page.dart';
import 'package:desafio2/repository/escribo_repo.dart';
import 'package:desafio2/shared/widgets/book_list_h.dart';
import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Best-Sellers',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllBooksPage())),
                    child: const Text('Ver todos'))
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: FutureBuilder(
                  future: Future.wait([consultarLivros()]),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BookListH(
                        livros: snapshot.data![0],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
            const SizedBox(height: 10),
            const Text(
              'Descubra novas Histórias',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}
