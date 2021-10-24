

import 'package:flutter/material.dart';
import 'package:luis_alzate_7_2021_2_p1/components/loader_component.dart';
import 'package:luis_alzate_7_2021_2_p1/models/memes.dart';

class infoMeme extends StatefulWidget {
  final Meme meme;

   infoMeme({required this.meme});

  @override
  _infoMemeState createState() => _infoMemeState();
}

class _infoMemeState extends State<infoMeme> {
  bool _showLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meme.submissionTitle),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
               _showMemeInfo()
            ],
          ),
          _showLoader ? LoaderComponent(text: 'Por favor espere...',) : Container(),    
        ],

      ),
    );
  }

 Widget _showMemeInfo() {
   return Container(
     margin: EdgeInsets.all(10),
     padding: EdgeInsets.all(10),
     child: Column(
       children: [
         
         Text(
          'Url: ', 
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )
        ),

        Text(
            widget.meme.submissionUrl,
            style: TextStyle(
            fontSize: 15
          )
        ),

         Text(
          'Autor: ', 
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )
        ),

        Text(
            widget.meme.author,
            style: TextStyle(
            fontSize: 15
          )
        ),

         Text(
          'Id Meme: ', 
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )
        ),

        Text(
            widget.meme.submissionId,
            style: TextStyle(
            fontSize: 15
          )
        ),

         Text(
          'Fecha Creación: ', 
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )
        ),

        Text(
            widget.meme.created,
            style: TextStyle(
            fontSize: 15
          )
        ),

          Text(
          'Tiempo de consumo: ', 
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )
        ),

        Text(
            widget.meme.timestamp,
            style: TextStyle(
            fontSize: 15
          )
        ),

              Text(
          'Permalink: ', 
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )
        ),

        Text(
            widget.meme.permalink,
            style: TextStyle(
            fontSize: 15
          )
        ),

         Text(
          'Imagen: ', 
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          )
        ),

       //Image(image: NetworkImage(widget.meme.submissionUrl), height: 350, width: 350,)




        
       ],
     )
   );

   
    
     
  }
  
}