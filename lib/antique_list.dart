import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'antique_detail.dart';

class AntiqueList extends StatefulWidget {
  @override
  AntiqueListState createState() {
    return new AntiqueListState();
  }
}

class AntiqueListState extends State<AntiqueList> {
  var antiques;
  Color mainColor = const Color(0xff3C3261);

  void getData() async {
    var data = await getJson();

    setState(() {
      antiques = data["antiques"];
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.3,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: new Icon(
          Icons.arrow_back,
          color: mainColor,
        ),
        title: new Text(
          'Antiques',
          style: TextStyle(
              color: mainColor,
              fontFamily: 'Arvo',
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[Icon(Icons.menu, color: mainColor)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AntiqueTitle(mainColor),
            Expanded(
              child: ListView.builder(
                itemCount: antiques == null ? 0 : antiques.length,
                itemBuilder: (BuildContext context, int i) {
                  return new FlatButton(
                    child: AntiqueCell(antiques, i),
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      Navigator.push(context,
                          new MaterialPageRoute(builder: (context) {
                        return AntiqueDetail(antiques[i]);
                      }));
                    },
                    color: Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AntiqueTitle extends StatelessWidget {
  final Color mainColor;

  AntiqueTitle(this.mainColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        child: Text(
          'Top Rated',
          style: TextStyle(
            fontSize: 40.0,
            color: mainColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arvo',
          ),
          textAlign: TextAlign.left,
        ));
  }
}

class AntiqueCell extends StatelessWidget {
  final antiques;
  final i;
  final Color mainColor = const Color(0xff3C3261);

  AntiqueCell(this.antiques, this.i);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Container(
                margin: EdgeInsets.all(16.0),
                child: Container(
                  width: 70.0,
                  height: 70.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey,
                  image: DecorationImage(
                      image: NetworkImage(antiques[i]['thumbnail-src']),
                      fit: BoxFit.cover),
                  boxShadow: [
                    BoxShadow(
                        color: mainColor,
                        blurRadius: 5.0,
                        offset: Offset(2.0, 5.0))
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                children: [
                  Text(
                    antiques[i]['title'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    antiques[i]['description'],
                    maxLines: 3,
                    style: TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    antiques[i]['title'],
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Arvo',
                        fontWeight: FontWeight.bold,
                        color: mainColor),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    "Price: " +
                        (antiques[i]['amount'] == null
                            ? ""
                            : antiques[i]['amount'].toString()),
                    maxLines: 3,
                    style: TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    "Title: " +
                        (antiques[i]['details'] == null
                            ? ""
                            : antiques[i]['details'].toString()),
                    maxLines: 1,
                    style: TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    "Width: " +
                        (antiques[i]['width'] == null
                            ? ""
                            : antiques[i]['width'].toString()),
                    maxLines: 1,
                    style: TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  ),
                  Padding(padding: const EdgeInsets.all(2.0)),
                  Text(
                    "Length: " +
                        (antiques[i]['length'] == null
                            ? ""
                            : antiques[i]['length'].toString()),
                    maxLines: 1,
                    style: TextStyle(
                        color: const Color(0xff8785A4), fontFamily: 'Arvo'),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )),
          ],
        ),
        Container(
          width: 300.0,
          height: 0.5,
          color: const Color(0xD2D2E1ff),
          margin: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}

Future getJson() async {
  var url = 'https://antiques-ddf55.firebaseapp.com/api/antiques';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
