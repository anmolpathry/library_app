import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:library_app/providers/books_provider.dart';
import 'package:share_plus/share_plus.dart';

class Details extends StatefulWidget {
  final dynamic selectedBook;
  final int index;
  
  Details({
    Key? key,
    this.selectedBook, this.index=-1,
  }) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
    bool des = false;
  @override
  Widget build(BuildContext context) {
    String description  = context.read<BooksProvider>().getDescription(widget.index);

    return Scaffold(
      appBar: AppBar(title: Text('Detalles del libro'), actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.public,
              color: Colors.white,
            ),
            onPressed: () {}),
        IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.white,
            ),
            onPressed: () async{
              await Share.share(
                'Título del libro: ${context.read<BooksProvider>().getTitle(widget.index)}\n Número de páginas: ${context.read<BooksProvider>().getPageCount(widget.index)}'
              );
            })
      ]),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Center(
              child: Container(
            height: 350,
            child: Image.network(
              context.read<BooksProvider>().getImage(widget.index),
              fit: BoxFit.fitWidth,
            ),
          )),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
               "${context.read<BooksProvider>().getTitle(widget.index)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)
            )
          ],
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left:10),
          child: Row(
            children: [
              Text(
                 "${context.read<BooksProvider>().getDate(widget.index)}",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left:10),
          child: Row(
            children: [
              Text(
                 "Páginas: ${context.read<BooksProvider>().getPageCount(widget.index)}",
                  style: TextStyle(fontSize: 15)
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left:10),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap:() {
                    des = !des;
                    setState(() {});
                    print(des);
                  },
                  child: __descriptionOverFlow(des,description)
                ),
              )
            ]
          ),
        )
      ]),
    );
  }

  Widget __descriptionOverFlow(bool des, String description){
    if(des){
      return Text(
      "${description}",
      style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
      //overflow: TextOverflow.ellipsis,
      //maxLines: 10,
    );
    }else{
    return Text(
      "${description}...",
      style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
      overflow: TextOverflow.ellipsis,
      maxLines: 4,
    );
    }
  }
  
}
