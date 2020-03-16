import 'package:flutter/material.dart';

class ItemNotFound extends StatelessWidget {

  final String title, message;
  final Function callback;

  const ItemNotFound({@required this.title, @required this.message, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[

          Card(
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(title),
                  subtitle: Text(message),
                ),
                RaisedButton(
                  child: Text('Reintentar'),
                  onPressed: ()=> callback(),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}