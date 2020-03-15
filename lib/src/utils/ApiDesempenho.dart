import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:desempenho/src/utils/ConfigUrl.dart';
import 'package:desempenho/src/models/Consultor.dart';


class ApiDesempenho {


  Future<Set<Consultor>> getConsultores() async {
    Set<Consultor> consultores = Set<Consultor>();
    http.Client client = new http.Client();
    http.Response response = await client.get( CONSULTORESALL );

    if( response.statusCode == 200 ) { // OK
      List responseJSON = json.decode( utf8.decode(response.bodyBytes) );

      responseJSON.map(( dynamic consultorData ) => 
        consultores.add( Consultor.fromApi( consultorData ) )).toSet();

    } else {
      throw Exception('No se resolvió la petición get: $CONSULTORESALL');
    }


    client?.close();
    return consultores;
  }


}
