import 'package:desempenho/src/models/Consultor.dart';
import 'package:desempenho/src/providers/Provider.dart';
import 'package:desempenho/src/providers/month_provider.dart';
import 'package:desempenho/src/widgets/Loading.dart';
import 'package:flutter/material.dart';

class ConsultoresPage extends StatefulWidget {
  @override
  _ConsultoresPageState createState() => _ConsultoresPageState();
}

class _ConsultoresPageState extends State<ConsultoresPage> {


  Set<Consultor> consultores;
  Set<Consultor> selectConsultores;

  bool loading = true;

  final estyleLabel = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estySubTitle = TextStyle(fontSize: 18.0, color: Colors.grey);

  String _optyearSel = '2007';
  String _optyearSela = '2007';
  String selectedonemonth = '01';
  String selectedonemontha = '01';

  List<String> _month = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'];
  List<String> _numm = ['01','02','03','04','05','06','07','08','09','10','11','12'];
  List<String> _year = ['2003', '2004', '2005', '2006', '2007'];

  List<DropdownMenuItem<String>> listMonth = [];
  List<DropdownMenuItem<String>> listYear = [];

  @override
  void initState() {
    _getConsultoresAll();
    selectConsultores = Set<Consultor>();
    super.initState();
  }

  void _getConsultoresAll() async {
    consultores = await Provider.desempenho.getConsultores();
    setState(() {
      loading = false;
    });
  }




  void loadData(){
    
    listMonth = [];

    for(var i = 0; i < _month.length; i++){      
      listMonth.add(new DropdownMenuItem(
        child: new Text(_month[i]),
        value: _numm[i],
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return loading ? Loading() : _buildView();
  }

  Widget _buildView(){
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _buildCustomAppBar(),

            Expanded(
              child: _buildCustomListView()
            )

            
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(){
    return Container(
      child: Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Periodo'),
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              _getMonth(),
              _getYear(),
              Text('a  '),
              _getMontha(),
              _getYeara(),
            ],
          )
        ],
      ),
      ),
    );
  }


  ListView _buildCustomListView(){
    return ListView.builder(
      itemCount: consultores.length,
      shrinkWrap: true, 
      itemBuilder: (BuildContext context, int index) {
        return _buildCustomItem(
          consultor: consultores.elementAt(index)
        );
      },
    );
  }

  Widget _buildCustomItem({ Consultor consultor }){
    return ListTile(
      title: Text('${consultor.no_usuario}'),
      trailing: Checkbox(
        onChanged: ( bool value ) => _selectConsultor( consultor ), 
        value: consultor.selected,
      ),
      onTap: () => _selectConsultor( consultor ) ,
    );
  }


  void _selectConsultor(Consultor consultor){
   
    if( consultor.selected ) {
      consultor.selected = false;
      selectConsultores.removeWhere(( Consultor c) => c.co_usuario == consultor.co_usuario );
    } else {
      consultor.selected = true;
      selectConsultores.add( consultor );
    }

    print('Consultores seleccionados: ${selectConsultores.length}');
    print('Consultores totales: ${consultores.length}');

    setState(() {});
  }







  Widget _getMonth() {
    return DropdownButton(
      value: selectedonemonth,
      items: listMonth, 
      hint: new Text('---'),
      onChanged: (value) {    
        print(value);
        setState(() {
          selectedonemonth  = value;
        });
      },
    );
  }

  Widget _getMontha() {
    return DropdownButton(
      value: selectedonemontha,
      items: listMonth, 
      hint: new Text('---'),
      onChanged: (value) {    
        print(value);
        setState(() {
          selectedonemontha  = value;
        });
      },
    );
  }

  List<DropdownMenuItem<String>> getYear() {

    List<DropdownMenuItem<String>> lista = new List();

    _year.forEach( (year){

      lista.add( DropdownMenuItem(
        child: Text(year),
        value: year,
      ));
    });

    return lista;

  }

  Widget _getYear() {

    return DropdownButton(
      value: _optyearSel,
      items: getYear(), 
      hint: new Text('---'),
      onChanged: (opt) {    
        print(opt);
        setState(() {
          _optyearSel = opt;                
        });
      },
    );
  }

  Widget _getYeara() {

    return DropdownButton(
      value: _optyearSela,
      items: getYear(), 
      hint: new Text('---'),
      onChanged: (opt) {    
        print(opt);
        setState(() {
          _optyearSela = opt;                
        });
      },
    );
  }

  Widget _listViewConsultores() {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: _listaConsultores(),
    );
  }

  List<Widget> _listaConsultores() {
    return [
      ListTile(title: Text('Hola Mundo')),
      Divider(),
      ListTile(title: Text('Hola Mundo')),
      Divider(),
      ListTile(title: Text('Hola Mundo')),      
    ];
  }

}