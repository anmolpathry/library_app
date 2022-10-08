import 'package:flutter/material.dart';
import 'package:library_app/http_request.dart';

class BooksProvider extends ChangeNotifier {
  bool _shimmer = false;
  bool _foundBooks = false;
  bool _text = true;
  bool _notFoundText = false;
  dynamic _books;

  bool get shimmer => _shimmer;
  bool get foundBooks => _foundBooks;
  bool get text => _text;
  bool get notFoundText => _notFoundText;
  dynamic get getBooks => _books;

  var request = HttpRequest();

  void setShimmer() {
    _shimmer = !_shimmer;
    notifyListeners();
  }

  void setText() {
    if (_text == true) _text = !_text;
    notifyListeners();
  }

  void setGrid() {
    _foundBooks = !_foundBooks;
    notifyListeners();
  }

  void setNotFoundText() {
    _notFoundText = !_notFoundText;
    notifyListeners();
  }

  Future<dynamic> getFoundBooks(var title) async {
    try {
      _books = await request.getBooks(title);
      print(_books);

      if (await _books["totalItems"]!= 0) {
        print("Hola");
        if(_foundBooks != true)setGrid();

      } else
      { 
        print(_notFoundText);
        print(_foundBooks);
        if(_notFoundText != true)setNotFoundText();
        if(_foundBooks == true) setGrid();

      } 
    } catch (e) {
      print(e.toString());
      if(_notFoundText != true)setNotFoundText();
      if(_foundBooks == true) setGrid();
    }
    notifyListeners();
  }

  int getLength(){
    try{
      return _books["items"].length;
    } catch(e){
       return 0;
    }
  }

  String getImage(int index) {
    try {
      return _books["items"][index]["volumeInfo"]["imageLinks"]["thumbnail"];
    } catch (e) {
      return 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png';
    }
  }

    String getTitle(int index) {
    try {
      return _books["items"][index]["volumeInfo"]["title"];
    } catch (e) {
      return '-';
    }
  }

  String getDate(int index) {
    try {
      return _books["items"][index]["volumeInfo"]["publishedDate"];
    } catch (e) {
      return '-';
    }
  }

  int getPageCount(int index) {
    try {
      return _books["items"][index]["volumeInfo"]["pageCount"];
    } catch (e) {
      return 0;
    }
  }

  String getDescription(int index) {
    try {
      return _books["items"][index]["volumeInfo"]["description"];
    } catch (e) {
      return '-';
    }
  }

}
