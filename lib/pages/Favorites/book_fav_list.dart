import 'package:desafio2/model/escribo_model.dart';
import 'package:desafio2/provider/fav_provider.dart';
import 'package:desafio2/repository/escribo_repo.dart';
import 'package:desafio2/shared/widgets/book_reader.dart';
import 'package:desafio2/shared/widgets/book_saver/get_book.dart';
import 'package:desafio2/shared/widgets/icons/fav_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookFavList extends StatefulWidget {
  final List<EscriboModel> livros;
  const BookFavList({super.key, required this.livros});

  @override
  State<BookFavList> createState() => _BookFavListState();
}

class _BookFavListState extends State<BookFavList> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteProvider>(context);
    return Consumer<FavoriteProvider>(builder: (context, escriboModel, child) {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 0.65),
          scrollDirection: Axis.vertical,
          itemCount: provider.books.length,
          itemBuilder: (context, index) {
            final livro = provider.books[index];
            final String bookNumber = livro.downloadUrl!
                .split('/')
                .last
                .replaceAll('3.images', '')
                .replaceAll('.images', '')
                .replaceAll('.noimages', '');
            String hth =
                '/data/data/com.caiobonalume.escribo.desafio2/app_flutter/books/$bookNumber';
            bool bookExist = false;
            return Container(
              margin: const EdgeInsets.only(top: 15),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 180,
                      height: 250,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.7),
                        child: Stack(
                          children: [
                            Ink(
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20.0),
                                onTap: () async {
                                  setState(() => loading = true);
                                  await createBooksFolder();

                                  await epubExists(hth).then((value) {
                                    return bookExist = value;
                                  });

                                  if (bookExist == false) {
                                    setState(() {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text(' Baixando livro...')));
                                    });
                                    await downloadEpub(livro.downloadUrl!);
                                    await saveEpubPath(livro.downloadUrl!);
                                    await readEpubPath().then((value) {
                                      Future.delayed(const Duration(seconds: 5),
                                          () => openReader(context, value!));
                                    });
                                  } else {
                                    await saveEpubPath(livro.downloadUrl!);
                                    await readEpubPath().then((value) {
                                      openReader(context, value!);
                                    });
                                  }
                                  setState(() => loading = false);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9, vertical: 16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Expanded(child: Row()),
                                        Text(
                                          livro.title!,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          livro.author!,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: 180,
                        child: Stack(
                          children: [
                            Align(
                              alignment: const Alignment(0, -1),
                              child: IgnorePointer(
                                ignoring: true,
                                child: Container(
                                  width: 150,
                                  height: 210,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(livro.coverUrl!),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const Alignment(0.8, -0.9),
                              child: RawMaterialButton(
                                  padding: const EdgeInsets.all(6),
                                  fillColor: Colors.white,
                                  shape: const CircleBorder(),
                                  onPressed: () {
                                    provider.toggleFavorite(livro);
                                  },
                                  child: provider.isFav(livro)
                                      ? const FavIconActive()
                                      : const FavIconDesactive()),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
            );
          });
    });
  }
}
