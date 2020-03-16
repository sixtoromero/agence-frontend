import 'package:desempenho/src/models/Relatorio.dart';
import 'package:desempenho/src/providers/Provider.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class GraficoPage extends StatefulWidget {
  @override
  _GraficoPageState createState() => _GraficoPageState();
}

class _GraficoPageState extends State<GraficoPage> {

  final estyleLabel = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);
  bool toggle = true;
  Map<String, double> dataMap = Map();  

  List<Color> colorList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.grey,
    Colors.lime,
    Colors.purpleAccent
  ];

  void togglePieChart() {
    setState(() {
      toggle = !toggle;
    });
  }

  @override
  void initState() {
    super.initState();        

    if( Provider.listRelatorio.isNotEmpty ){

        Provider.listRelatorio.forEach(( Relatorio relatorio){
          dataMap.putIfAbsent(relatorio.no_usuario, () => relatorio.receita_liquida);          
        });        

        
        // dataMap.putIfAbsent("React", () => 3);
        // dataMap.putIfAbsent("Xamarin", () => 2);
        // dataMap.putIfAbsent("Ionic", () => 2);
    }
    
    //Provider.listRelatorio    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: buildView(),
      ),
    );
  }

  Widget buildView(){
    return  Container(
      child: ListView(
        children: <Widget>[
          Divider(),
          Text('Gráfica Torta', style: estyleLabel),
          Divider(),
          Column(
            children: <Widget>[
              _buildPie(),
            ],
          ),
          Divider(),
          Text('Gráfica Barra', style: estyleLabel),
          Divider(),
        ],
      )
    );
  }

  Widget _buildPie() {
    return Center(
          child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32.0,
                  chartRadius: MediaQuery.of(context).size.width / 2.7,
                  showChartValuesInPercentage: true,
                  showChartValues: true,
                  showChartValuesOutside: false,
                  chartValueBackgroundColor: Colors.grey[200],
                  colorList: colorList,
                  showLegends: true,
                  legendPosition: LegendPosition.right,
                  decimalPlaces: 1,
                  showChartValueLabel: true,
                  initialAngle: 0,
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.blueGrey[900].withOpacity(0.9),
                  ),
                  chartType: ChartType.disc,
                )
        );
  }

}