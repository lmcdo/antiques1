import 'package:flutter/material.dart';
import 'antique_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Antiques r us',
      home: AntiqueList(),
    );
  }
}