import 'package:desafio2/model/escribo_model.dart';
import 'package:desafio2/repository/escribo_repo.dart';
import 'package:desafio2/shared/widgets/book_reader.dart';
import 'package:desafio2/shared/widgets/book_saver/get_book.dart';
import 'package:desafio2/shared/widgets/icons/fav_icon.dart';
import 'package:flutter/material.dart';

class BookListH extends StatefulWidget {
  final List<EscriboModel> livros;
  const BookListH({super.key, required this.livros});

  @override
  State<BookListH> createState() => _BookListHState();
}

bool isFav = false;

class _BookListHState extends State<BookListH> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.livros.length,
      itemBuilder: (context, index) {
        final EscriboModel livro = widget.livros[index];
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
          margin: const EdgeInsets.only(right: 15),
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
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.7),
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(' Baixando livro...')));
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(child: Row()),
                                    Text(
                                      "${livro.title!.characters.take(15)}...",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${livro.author!.characters.take(15)}...",
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
              SizedBox(
                  width: 180,
                  child: Stack(
                    children: [
                      IgnorePointer(
                        ignoring: true,
                        child: Align(
                          alignment: const Alignment(0, -0.6),
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
                        alignment: const Alignment(0.8, -0.8),
                        child: RawMaterialButton(
                            padding: const EdgeInsets.all(6),
                            fillColor: Colors.white,
                            shape: const CircleBorder(),
                            onPressed: () {
                              setState(() {
                                isFav = !isFav;
                              });
                            },
                            child: isFav == false
                                ? const FavIconDesactive()
                                : const FavIconActive()),
                      )
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }
}
