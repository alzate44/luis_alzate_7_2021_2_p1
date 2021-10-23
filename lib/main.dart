import 'package:flutter/material.dart';
import 'package:luis_alzate_7_2021_2_p1/models/memes.dart';
import 'package:luis_alzate_7_2021_2_p1/screens/memes_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Api Memes - Luis Alejandro Alzate',
      home: MemesList(),
    );
  }
}