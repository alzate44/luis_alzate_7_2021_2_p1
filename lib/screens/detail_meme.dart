import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:luis_alzate_7_2021_2_p1/components/loader_component.dart';
import 'package:luis_alzate_7_2021_2_p1/helpers/constans.dart';
import 'package:luis_alzate_7_2021_2_p1/models/memes.dart';

class DetailMeme extends StatefulWidget {
  final Meme meme;
  

  DetailMeme({required this.meme});

  @override
  _DetailMemeState createState() => _DetailMemeState();
}

class _DetailMemeState extends State<DetailMeme> {
  List<Meme> _memes = [];
  bool _showLoader = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text(widget.meme.submissionTitle), 
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : _getContent(),
      ),
    );
  }

  void _getMemes() async {
    setState(() {
      _showLoader = true;
    });
    var url = Uri.parse('${Constans.apiUrl}/memes/');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      }
    );
      setState(() {
      _showLoader = false;
    });
    var body = response.body;
    var decodedJson = jsonDecode(body);

    if(decodedJson != null){
      for (var item in decodedJson['data']){
        _memes.add(Meme.fromJson(item)); //loading memes in variable _memes
      }
    }
    print(_memes);
  }

  Widget _getContent() {
   return  _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: Text('No hay Memes para mostrar.',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
    );
  }

 Widget _getListView() {

   return ListView(
    children: _memes.map((e)  {
      return Card(

        child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailMeme(
                  meme: e,
                )
              )
            );
          },
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  e.submissionTitle, 
                  style: TextStyle(
                    fontSize: 25
                    ),
                    ),
                    
                 //Image(image: NetworkImage(e.submissionUrl))
                 Text(
                   e.submissionUrl, 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:  FontWeight.bold
                    ),
                    ),
                    
                    Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      );
    }).toList()
   );
 }
}