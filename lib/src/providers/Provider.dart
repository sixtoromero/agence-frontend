import 'package:flutter/material.dart';
import 'package:desempenho/src/utils/ApiDesempenho.dart';

class Provider extends InheritedWidget {

  // Instancia de la API Desempenho
  static ApiDesempenho desempenho = new ApiDesempenho();

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

