import 'package:desempenho/src/models/Relatorio.dart';
import 'package:desempenho/src/widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:desempenho/src/providers/Provider.dart';
import 'package:desempenho/src/utils/ApiDesempenho.dart';

class RelatorioPage extends StatefulWidget {
  @override
  _RelatorioPageState createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {

  Set<Relatorio> relatorios;
  bool loading = true;
  
  @override
  void initState() {
    getRelatorios();
    super.initState();
  }

  void getRelatorios() async {
    relatorios  = await  Provider.desempenho.getRelatorios();

    if( mounted ){
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: loading ? Loading() : buildView(),
      ),
    );
  }

  Widget buildView(){
    return  Container(
          child: ListView(
            children: <Widget>[
              Text('Hemos seleccionado a ${Provider.selectConsultores.length}'),
              Text('Fecha inicial ${Provider.periodoFilter.dateStart}'),
              Text('Fecha final ${Provider.periodoFilter.dateEnd}'),
              
              DataTable(
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('PRUEBA')
                  ),
                  DataColumn(
                    label: Text('PRUEBA')
                  ),
                  DataColumn(
                    label: Text('PRUEBA')
                  ),
                ],
                rows: relatorios.map((relatorio ) => DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text(relatorio.no_usuario)
                    ),
                    DataCell(
                      Text(relatorio.comissao.toString())
                    ),
                    DataCell(
                      Text(relatorio.lucro.toString())
                    ),
                  ]
                )
                ).toList(),

              )

            ],
          ),
        );
  }

  ListView buildCustomListView(){
    return ListView.builder(
      itemCount: relatorios.length,
      primary: false,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return buildCustomItem( relatorios.elementAt(index) );
      },
    );
  }

  Widget buildCustomItem( Relatorio relatorio ){
    return ListTile(
      title: Text(relatorio.co_usuario),
      subtitle: Text(relatorio.comissao.toString()),
    );
  }

}