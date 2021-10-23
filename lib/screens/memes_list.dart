import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:luis_alzate_7_2021_2_p1/models/memes.dart';
import 'package:luis_alzate_7_2021_2_p1/helpers/constans.dart';



class MemesList extends StatefulWidget {
  const MemesList({ Key? key }) : super(key: key);

  @override
  _MemesListState createState() => _MemesListState();
}

class _MemesListState extends State<MemesList> {
  List<Meme> _memes = [];

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
          child: Text('Lista de memes') ,
          ),
      
    );
  }

  void _getMemes() async {

    var url = Uri.parse('${Constans.apiUrl}/https://api.doge-meme.lol/docs#/health/pong_v1_ping_get');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
      }
    );
    print(response);
  }
}