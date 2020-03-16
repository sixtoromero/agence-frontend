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
  final oCcy = new NumberFormat("#,##0.00", "en");

  @override
  void initState() {
    getRelatorios();
    super.initState();
  }

  void getRelatorios() async {
    relatorios  = await  Provider.desempenho.getRelatorios();
     
    String co_usuario; 
    double liquida, fixo, comissao, lucro = 0.0;

    relatorios.forEach((a){

      relatorios.forEach((b){
        if( a.co_usuario == b.co_usuario ){
          if( co_usuario != b.co_usuario ){
            liquida = 0.0;
            fixo = 0.0;
            comissao = 0.0; 
            lucro = 0.0;
          }
          co_usuario = a.co_usuario;
          liquida += b.receita_liquida;          
          fixo += b.custo_fijo;          
          comissao += b.comissao;
          lucro += b.lucro;

          a.totalLiquida = liquida;
          a.totalFixo = fixo;
          a.totalComissao = comissao;
          a.lucro = lucro;

          

          
        }
      });
    });

    Provider.listRelatorio = relatorios;

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


        if( index %2 == 0 ){
          
          print('Nombre: ${relatorios.elementAt(index).no_usuario}');
           print('Receita Liquida ${relatorios.elementAt(index).totalLiquida}');
           print('Custo Fixo ${relatorios.elementAt(index).totalFixo}');
           print('Comissao ${relatorios.elementAt(index).totalComissao}');
           print('Lucro ${relatorios.elementAt(index).totalLucro}');
           print('\n');
          
        }            

        return buildCustomItem( relatorios.elementAt(index), index);
      },
    );
  }

  Widget buildCustomItem( Relatorio relatorio, int index ){    
    
    
    
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
          subtitle: (index %2 == 0 ) ? Text(formatEN.format(Provider.periodoFilter.dateStart)) : Text(formatEN.format(Provider.periodoFilter.dateEnd)),
        ),
        ListTile(
          title: Text('Receita Líquida'),
          subtitle: Text('\$${receitaLiquida}'),
        ),
        ListTile(
          title: Text('Custo Fixo'),
          subtitle: Text('\$${custoFixo}'),
        ),
        ListTile(
          title: Text('Comissão'),
          subtitle: Text('\$${comissao}'),
        ),
        ListTile(
          title: Text('Lucro'),
          subtitle: Text('\$${lucro}'),
        ),
        (index%2!=0) ? buildListTileTotales(relatorio) : Container(),
        Divider(thickness: 2.0)        
      ],
    );    
    
    /*
    return ListTile(
      title: Text(relatorio.co_usuario),
      subtitle: Text(relatorio.comissao.toString()),
    );*/
  }

  Widget buildListTileTotales(Relatorio relatorio) {
    print('entrando en listtile totales');
    return Column(
      children: <Widget>[
        Divider(
          color: Colors.black,
          thickness: 0.5,
        ),
        ListTile(
          title: Text('Total Receita líquida:'),
          trailing: Text('\$${oCcy.format(relatorio.totalLiquida)}'),
        ),
        ListTile(
          title: Text('Total Custo Fixo:'),
          trailing: Text('\$${oCcy.format(relatorio.totalFixo)}'),
        ),
        ListTile(
          title: Text('Total Comissão:'),
          trailing: Text('\$${oCcy.format(relatorio.totalComissao)}'),
        ),
        ListTile(
          title: Text('Total Lucro:'),
          trailing: Text('\$${oCcy.format(relatorio.totalLucro)}'),
        ),

      ],

    );
  }  
}