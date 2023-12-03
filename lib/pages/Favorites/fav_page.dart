import 'package:desafio2/model/escribo_model.dart';
import 'package:desafio2/pages/Favorites/book_fav_list.dart';
import 'package:desafio2/repository/escribo_repo.dart';
import 'package:desafio2/repository/fav_repo.dart';
import 'package:flutter/material.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    FavRepo favRepo = FavRepo();
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 600,
              child: FutureBuilder<List<EscriboModel>>(
                  future: favRepo.getFavorites(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return BookFavList(livros: snapshot.data!);
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
