import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:luis_alzate_7_2021_2_p1/models/memes.dart';
import 'package:luis_alzate_7_2021_2_p1/helpers/constans.dart';
import 'package:luis_alzate_7_2021_2_p1/components/loader_component.dart';



class MemesList extends StatefulWidget {
  const MemesList({ Key? key }) : super(key: key);

  @override
  _MemesListState createState() => _MemesListState();
}

class _MemesListState extends State<MemesList> {
  List<Meme> _memes = [];
  bool _showLoader = false;

  @override
  void initState() {
    // CUANDO LA PANTALLA CAMBIA
    super.initState();
    _getMemes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de Memes') ,
        ),
        body: Center(
          child: _showLoader ? LoaderComponent(text: 'Por favor espere...') : Text ('Lista de memes')
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
}