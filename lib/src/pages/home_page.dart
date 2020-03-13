import 'package:desempenho/src/pages/consultores_page.dart';
import 'package:desempenho/src/pages/grafico_page.dart';
import 'package:desempenho/src/pages/relatorio_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: <Widget>[
              _callPage(currentIndex)              
            ],
          ),
      ),
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _callPage(int paginaActual){
    switch(paginaActual){

      case 0: return ConsultoresPage();
      case 1: return RelatorioPage();
      case 2: return GraficoPage();

      default:
        return ConsultoresPage();
    }
  } 

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Consultores')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_on),
          title: Text('Relatório')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          title: Text('Gráfico')
        )
      ],
    );
  }
}