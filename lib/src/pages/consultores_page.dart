import 'package:desempenho/src/widgets/ItemNotFound.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:desempenho/src/models/Consultor.dart';
import 'package:desempenho/src/providers/Provider.dart';
import 'package:desempenho/src/widgets/Loading.dart';


class ConsultoresPage extends StatefulWidget {
  @override
  _ConsultoresPageState createState() => _ConsultoresPageState();
}

class _ConsultoresPageState extends State<ConsultoresPage> {


  Set<Consultor> consultores;
  bool loading = true;

  final estyleLabel = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  final estySubTitle = TextStyle(fontSize: 18.0, color: Colors.grey);

  @override
  void initState() {
    _getConsultoresAll();
    super.initState();
  }

  void _getConsultoresAll() async {
    try {
      consultores = await Provider.desempenho.getConsultores();
      consultores.forEach(( Consultor consultor ){
        Provider.selectConsultores.forEach(( Consultor selected){
          if( consultor.co_usuario == selected.co_usuario ){
            consultor.selected = true;
          }
        });
      });
      
      //Define si el estado de la vista está construido.
      if( mounted ) {
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
      //showToast(e.toString(), context, toast.Toast.BOTTOM);
    }
  }
  //bool _checkConsultorSelected( Consultor consultor ) => Provider.selectConsultores.contains(consultor);
  void _selectConsultor(Consultor consultor){
   
    if( consultor.selected ) {
      consultor.selected = false;
      Provider.selectConsultores.removeWhere(( Consultor c) => c.co_usuario == consultor.co_usuario );
    } else {
      consultor.selected = true;
      Provider.selectConsultores.add( consultor );
  
    }

    setState(() {});
  }

  void _showDatePicker() async {
   
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
        context: context,
        initialFirstDate: Provider.periodoFilter.dateStart,
        initialLastDate: Provider.periodoFilter.dateEnd,
        firstDate: DateTime.parse('2003-01-01 00:00:00'),
        lastDate: DateTime.parse('2007-12-31 00:00:00')
      );
      if (picked != null && picked.length == 2) {
         Provider.periodoFilter.dateStart = picked.elementAt(0);
         Provider.periodoFilter.dateEnd = picked.elementAt(1);
      }
  }

  void _callbackItemNotFound(){
    setState(() {
      loading = true;
    });
    _getConsultoresAll();
  }


  @override
  Widget build(BuildContext context) {
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
         
          
          consultores != null ?
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Periodo'),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.white
                  )
                ),
                onPressed: _showDatePicker,
              )
            ],
          ) : Container()
        ],
      ),
      ),
    );
  }

  Widget _buildCustomListView(){
    if( consultores != null  ) {
      return ListView.builder(
        itemCount: consultores.length,
        shrinkWrap: true, 
        itemBuilder: (BuildContext context, int index) {
          return _buildCustomItem(
            consultor: consultores.elementAt(index)
          );
        },
      );
    } else {
      return ItemNotFound(
        title: 'Consultores',
        message: 'No se ha podido descargar el contenido.', 
        callback: _callbackItemNotFound,
      );
    }



  }

  Widget _buildCustomItem({ Consultor consultor }){
    return ListTile(
      title: Text('${consultor.no_usuario}'),
      trailing: Checkbox(
        onChanged: ( bool value ) => _selectConsultor( consultor ), 
        value: consultor.selected,
      ),
      onTap: () => _selectConsultor( consultor ),
    );
  }


}