import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:library_app/providers/books_provider.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';

import 'details.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final _txtTitle = TextEditingController();
    dynamic books = context.watch<BooksProvider>().getBooks;

    return Scaffold(
        appBar: AppBar(
          title: Text('Libreria free to play'),
        ),
        body: Column(children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: _txtTitle,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                    onTap: () async {
                      print(_txtTitle.text);

                      //Ocultar el teclado
                      //FocusManager.instance.primaryFocus?.unfocus();

                      context.read<BooksProvider>().setShimmer();
                      context.read<BooksProvider>().setText();
                      await context
                          .read<BooksProvider>()
                          .getFoundBooks(_txtTitle.text);
                      context.read<BooksProvider>().setShimmer();

                      print(books);
                    },
                    child: Icon(Icons.search)),
                labelText: "Ingresa titulo",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          context.watch<BooksProvider>().text
              ? Expanded(
                  child: Container(
                      child: Center(
                          child: Text("Ingrese palabra para buscar libro"))))
              : context.watch<BooksProvider>().shimmer
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        VideoShimmer(),
                        VideoShimmer(),
                        VideoShimmer(),
                      ],
                    )
                  : context.watch<BooksProvider>().foundBooks
                      ? Expanded(
                          child: Container(
                          child: GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            children: List.generate(
                              context.read<BooksProvider>().getLength(),
                              (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => Details(
                                          selectedBook: books[index],
                                          index: index
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Column(children: [
                                      Expanded(
                                        child: Image.network(
                                            context
                                                .read<BooksProvider>()
                                                .getImage(index),
                                            fit: BoxFit.fitWidth),
                                      ),
                                      Container(
                                        child: Text(
                                            "${context.read<BooksProvider>().getTitle(index)}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      )
                                    ]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ))
                      : context.watch<BooksProvider>().notFoundText
                          ? Expanded(
                              child: Container(
                                  child: Center(
                                      child: Text("No se encontraron libros"))))
                          : Text("")
        ]));
  }
}
