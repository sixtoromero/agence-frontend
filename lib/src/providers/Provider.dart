import 'package:desempenho/src/models/Consultor.dart';
import 'package:desempenho/src/models/Relatorio.dart';
import 'package:flutter/material.dart';
import 'package:desempenho/src/utils/ApiDesempenho.dart';
import 'package:desempenho/src/models/PeriodoFilter.dart';

class Provider extends InheritedWidget {

  // Instancia de la API Desempenho
  static ApiDesempenho desempenho = new ApiDesempenho();

  static PeriodoFilter periodoFilter = new PeriodoFilter(
    dateStart: DateTime.parse('2007-01-25 00:00:00'),
    dateEnd: DateTime.parse('2007-02-01 00:00:00')
  );

  // Total count
  static int pageEnabled = 0;

  // Consultores seleccionados
  static Set<Consultor> selectConsultores = new Set<Consultor>();
  static Set<Relatorio> listRelatorio = new Set<Relatorio>();

  // Instanciamos una sola vez la clase Provider
  static Provider _instancia;

  // Creamos un metodo interno para instanciar una sola vez la clase Provider.
  Provider._internal({Key key, Widget child }) : super(key: key, child: child);

  // Con factory nos permite instanciar una nueva clase de Provider 
  factory Provider({ Key key, Widget child }){

       // Comprobamos si la instancia es null
       // En caso de que sea null, instanciamos una nueva clase Provider.
      if( _instancia == null ) {
        _instancia = new Provider._internal(key: key, child: child);
      }
      
      // Retornamos la instancia.
      return _instancia;
  }


  // Dibujamos a todos los hijos la nueva informacion que contenga el provider.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;



}

