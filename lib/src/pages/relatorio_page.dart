import 'package:flutter/material.dart';
import 'package:desempenho/src/widgets/Loading.dart';
import 'package:intl/intl.dart';

import 'package:desempenho/src/models/Relatorio.dart';
import 'package:desempenho/src/providers/Provider.dart';
//import 'package:desempenho/src/utils/ApiDesempenho.dart';

class RelatorioPage extends StatefulWidget {
  @override
  _RelatorioPageState createState() => _RelatorioPageState();
}

class _RelatorioPageState extends State<RelatorioPage> {

  final estyleLabel = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  DateFormat formatEN = DateFormat('yyy-MM-dd');

  Set<Relatorio> relatorios;
  Set<Relatorio> setRelatorios = new Set<Relatorio>();

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
              // Text('Hemos seleccionado a ${Provider.selectConsultores.length}'),
              // Text('Fecha inicial ${Provider.periodoFilter.dateStart}'),
              // Text('Fecha final ${Provider.periodoFilter.dateEnd}'),
              buildCustomListView(),
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
        return buildCustomItem( relatorios.elementAt(index), (index % 2) == 0 ? formatEN.format(Provider.periodoFilter.dateEnd) :  formatEN.format(Provider.periodoFilter.dateStart));
      },
    );
  }

  Widget buildCustomItem( Relatorio relatorio, String date ){    
    
    final oCcy = new NumberFormat("#,##0.00", "en");
    
    String receitaLiquida = oCcy.format(relatorio.receita_liquida);
    String custoFixo = oCcy.format(relatorio.custo_fijo);
    String comissao = oCcy.format(relatorio.comissao);
    String lucro = oCcy.format(relatorio.lucro);

    return Column(
      children: <Widget>[
        Divider(),
        Text(relatorio.no_usuario, style: estyleLabel),        
        ListTile(
          title: Text('Periodo'),
          subtitle: Text(date),
        ),
        ListTile(
          title: Text('Receita Líquida'),
          subtitle: Text(receitaLiquida),
        ),
        ListTile(
          title: Text('Custo Fixo'),
          subtitle: Text(custoFixo),
        ),
        ListTile(
          title: Text('Comissão'),
          subtitle: Text(comissao),
        ),
        ListTile(
          title: Text('Lucro'),
          subtitle: Text(lucro),
        ),
        Divider(thickness: 2.0)
      ],
    );    
    
    /*
    return ListTile(
      title: Text(relatorio.co_usuario),
      subtitle: Text(relatorio.comissao.toString()),
    );*/
  }

  Widget buildDataTable() {
    return DataTable(
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
    );
  }
}