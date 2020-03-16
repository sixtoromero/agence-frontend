import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:desempenho/src/utils/ConfigUrl.dart';
import 'package:desempenho/src/providers/Provider.dart';
import 'package:desempenho/src/models/Relatorio.dart';
import 'package:desempenho/src/models/Consultor.dart';


class ApiDesempenho {


  Future<Set<Consultor>> getConsultores() async {
    Set<Consultor> consultores = Set<Consultor>();
    http.Client client = new http.Client();
    http.Response response = await client.get( CONSULTORESALL );

    if( response.statusCode == 200 ) { // OK
      List responseJSON = json.decode( utf8.decode(response.bodyBytes) );

      responseJSON.map(( dynamic consultorData ){
          Consultor consultor = Consultor.fromApi( consultorData );                            
          consultores.add( consultor );
        }
      ).toSet();

    } else {
      throw Exception('No se resolvió la petición get: $CONSULTORESALL');
    }


    client?.close();
    return consultores;
  }

  Future<Set<Relatorio>> getRelatorios() async {
    DateFormat formatEN = DateFormat('yyy-MM-dd');
    Set<Relatorio> relatorios = Set<Relatorio>();
    Response response;
    Dio dio = new Dio();


    await Future.forEach(Provider.selectConsultores, ( Consultor consultor ) async {
      
      // response = await dio.get(
      //   '$RELATORIOALL/${consultor.co_usuario}/${formatEN.format(Provider.periodoFilter.dateStart)}/${formatEN.format(Provider.periodoFilter.dateEnd)}'
      // );
      // await response.data.map(( dynamic relatorioJSON) async =>  relatorios.add( Relatorio.fromAPI(relatorioJSON, consultor.co_usuario, consultor.no_usuario) )).toSet();

      response = await dio.get(
        '$RELATORIO/${consultor.co_usuario}/${formatEN.format(Provider.periodoFilter.dateStart)}'
      );
      await response.data.map(( dynamic relatorioJSON) async =>  relatorios.add( Relatorio.fromAPI(relatorioJSON, consultor.co_usuario, consultor.no_usuario) )).toSet();

      response = await dio.get(
        '$RELATORIO/${consultor.co_usuario}/${formatEN.format(Provider.periodoFilter.dateEnd)}'
      );
      await response.data.map(( dynamic relatorioJSON) async =>  relatorios.add( Relatorio.fromAPI(relatorioJSON, consultor.co_usuario, consultor.no_usuario) )).toSet();      

    });
    
    return relatorios;

  }
}
