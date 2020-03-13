import 'package:flutter/material.dart';

class ConsultoresPage extends StatefulWidget {
  @override
  _ConsultoresPageState createState() => _ConsultoresPageState();
}

class _ConsultoresPageState extends State<ConsultoresPage> {

  final estyleLabel = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estySubTitle = TextStyle(fontSize: 18.0, color: Colors.grey);

  List<DropdownMenuItem<String>> listMonth = [];
  List<DropdownMenuItem<String>> listYear = [];

  String selectedonemonth = null;

  void loadData(){
    
    listMonth = [];

    listMonth.add(new DropdownMenuItem(
      child: new Text('Jan'), 
      value: '01',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Fev'), 
      value: '02',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Mar'), 
      value: '03',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Abr'), 
      value: '04',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Mai'), 
      value: '05',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Jun'), 
      value: '06',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Jul'), 
      value: '07',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Ago'), 
      value: '08',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Set'), 
      value: '09',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Out'), 
      value: '10',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Nov'), 
      value: '11',
    ));

    listMonth.add(new DropdownMenuItem(
      child: new Text('Dez'), 
      value: '12',
    ));

  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Periodo'),
            Row(
              children: <Widget>[
                _peronemonth(),
                _peroneyear(),
              ],
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _peronemonth() {
    return DropdownButton(
      value: selectedonemonth,
      items: listMonth, 
      hint: new Text('Mes'),
      onChanged: (value) {        
        setState(() {
          selectedonemonth  = value;
        });
      },
    );
  }

  Widget _peroneyear() {
      return DropdownButton(
        items: listMonth, 
        onChanged: null,
        );      
  }

  Widget pertwomonth() {

  }

  pertwoyear() {
      
  }

}