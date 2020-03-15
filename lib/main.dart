import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:desempenho/src/pages/home_page.dart';
import 'package:desempenho/src/providers/Provider.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', 'PT'), // Portuguese (plus one country variation)
          const Locale('es', 'ES'),
        ],
        title: 'Control de Actividades',
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage()
        },
      ),
    );
  }
}