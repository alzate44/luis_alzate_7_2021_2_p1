import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

import 'package:luis_alzate_7_2021_2_p1/models/memes.dart';
import 'package:luis_alzate_7_2021_2_p1/helpers/constans.dart';
import 'package:luis_alzate_7_2021_2_p1/components/loader_component.dart';
import 'package:luis_alzate_7_2021_2_p1/screens/detail_meme.dart';



class MemesList extends StatefulWidget {
  
  @override
  _MemesListState createState() => _MemesListState();
}

class _MemesListState extends State<MemesList> {
  List<Meme> _memes = [];
  bool _showLoader = false;
  String _search = ''; 
  bool _isFiltered = false;

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
        actions: <Widget>[
          _isFiltered
          ? IconButton(
            onPressed: _removeFilter,
            icon: Icon(Icons.filter_none),
          )
          : IconButton(
            onPressed: _showFilter,
            icon: Icon(Icons.filter_alt),
          )
        ],
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

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none){
        setState(() {
        _showLoader = false;
      });

      await showAlertDialog(
        context : context,
        title : 'Error de conexión',
        message : 'Verifica la conexión a internet.',
        actions: <AlertDialogAction>[
          AlertDialogAction(key: null, label: 'Aceptar'),
        ]
      );
        return;
    }
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
    return _memes.length == 0
    ? _noContent()
    : _getListView();
  }

  Widget _noContent() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(25),
        child: Text(
          _isFiltered
          ? 'No Hay memes con ese criterio de búsqueda.'
          :'No hay Memes para mostrar.',
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
                builder: (context) => infoMeme(
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

                // FadeInImage(
                //   placeholder: AssetImage('assets/meme.png'),
                //    image: NetworkImage(e.submissionUrl),
                //    width : 80,
                //    height : 80,
                //    fit: BoxFit.cover,
                //    )
                //  if(e.submissionTitle.toLowerCase().contains('png')) {
                //    Image(image: NetworkImage(e.submissionUrl))
                //  }  

                 //Image(image: NetworkImage('/assets/meme.png')),
                 
                 Text(
                   e.submissionUrl, 
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:  FontWeight.bold
                    ),
                    ),
                    
                    
              ],
            ),
          ),
        ),
      );
    }).toList()
   );
 }

  void _removeFilter() {
    setState(() {
      _isFiltered = false;
    });
    _getMemes();
 }

   void _showFilter() {

    showDialog(
      context: context, 
     builder: (context){
       return AlertDialog(
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(15)
           ),
           title: Text('Filtrar memes'),
           content: Column(
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[
               Text('Escriba las primeras letras del nombre del Meme'),
               SizedBox(height: 10),
               TextField(
                 autofocus: true,
                 decoration: InputDecoration(
                   hintText: 'Criterio de búsqueda...',
                   labelText: 'Buscar',
                   suffixIcon: Icon(Icons.search)
                 ),
                 onChanged: (value){
                  
                     _search = value; 
                   
                 },
               )
             ],
           ),
           actions: <Widget>[
             TextButton(
               onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar')
              ),
              TextButton(
               onPressed: () => _filter(),
              child: Text('Filtrar')
              ),
           ],
       );
     }
     );
  }

  void _filter() {
    if(_search.isEmpty){
      return;
    }
    List<Meme> filteredList = [];
    for (var meme in _memes) {
      if(meme.submissionTitle.toLowerCase().contains(_search.toLowerCase())){
        filteredList.add(meme);
      }
      
    }
    setState(() {
      _memes = filteredList;
      _isFiltered = true;
    });

    Navigator.of(context).pop();
  }
}