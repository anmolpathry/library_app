import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:library_app/providers/books_provider.dart';

import 'home_page.dart';

void main() => runApp(
  ChangeNotifierProvider(
        create: (context) => BooksProvider(),
        child: MyApp())
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color.fromARGB(255, 78, 78, 78)
        )
      ),
      home: HomePage(),
    );
  }
}

