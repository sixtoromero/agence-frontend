import 'package:flutter/material.dart';

class ConsultoresPage extends StatefulWidget {
  @override
  _ConsultoresPageState createState() => _ConsultoresPageState();
}

class _ConsultoresPageState extends State<ConsultoresPage> {

  final estyleLabel = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estySubTitle = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text('Periodo', style: estyleLabel),
                  ],
                ),
                Icon(Icons.star, color: Colors.red, size: 30.0),
                Text('41', style: TextStyle(fontSize: 20.0))
              ],
            ),
          ],
        ),
      ),
    );
  }



}