import 'dart:convert';

import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List data
  ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("antiques app"),
      ),
      body: Container(
        child: Center(
            child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('json/antiques.json'),
          builder: (context, snapshot) {
            // decode json
            var mydata = json.decode(snapshot.data.toString());

            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Category: " + mydata[index]['dropdown']),
                      Text("Sub-category: " + mydata[index]['list-unstyled']),
                      Text("Title: " + mydata[index]['title']),
                      Text("Description: " + mydata[index]['description'] ?? ""),
                      
                      Text("Year: " + (mydata[index]['details'] == null ? "" : mydata[index]['details'].toString())),
                      Text("Height: " + (mydata[index]['height'] == null ? "" : mydata[index]['height'].toString())),
                      Text("Length: " + (mydata[index]['length'] == null ? "" : mydata[index]['length'].toString())),

                    ],
                  ),
                );
              },
              itemCount: mydata == null ? 0 : mydata.length,
            );
          },
        )
        )
        ,
      ),
    );
  }
}
