import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class _MonthProvider {
  List<dynamic> listmonth = [];

  _MonthProvider() {

  }

  Future<List<dynamic>> loadDataMonth() async {
    final resp = await rootBundle.loadString('data/month.json');

    Map dataMap = json.decode( resp );
    listmonth = dataMap['month'];

    return listmonth;
  }

}

final monthProvider = new _MonthProvider();