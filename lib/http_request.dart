import 'dart:convert';

import 'package:http/http.dart';

class HttpRequest {
  static final HttpRequest _singleton = HttpRequest._internal();

  factory HttpRequest(){
    return _singleton;
  }

  HttpRequest._internal();

  Future <dynamic> getBooks(var title)async{
    try{
      var _response = await get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=${title}'));
      if(_response.statusCode == 200){
        var _content = jsonDecode(_response.body);
        return _content;
      }
    }catch (e){
      print(e.toString());
    }
  }
}