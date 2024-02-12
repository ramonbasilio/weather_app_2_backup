// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import '../constant/constants.dart';
import 'package:intl/intl.dart';

class Utils {
  static String utf8convert(String text) {
    List<int> bytes = text.toString().codeUnits;
    return utf8.decode(bytes);
  }

  static String NightOrDay(String url) {
    String result = '';
    List<String> list = url.split('/');
    for (var elemento in list) {
      if (elemento == 'day' || elemento == 'night') {
        result = elemento;
      }
    }
    return result;
  }

  static String NameImage(String url) {
    String result = '';
    List<String> list = url.split('/');
    for (var elemento in list) {
      if (elemento.contains('.png')) {
        result = elemento;
      }
    }
    return result;
  }

  static String DataFormated(String date) {
    return DateFormat('dd/MM/yyyy HH:hh')
        .format(DateTime.parse(date))
        .toString();
  }

  static String DataFormatedResumed(String date) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(date)).toString();
  }

  static String HourFormated(String date) {
    return DateFormat('HH').format(DateTime.parse(date)).toString();
  }

  static String HourSmall(String date) {
    return DateFormat('H').format(DateTime.parse(date)).toString();
  }

  static List HourlyForecast(List hour) {
    List temp = [];
    for (int i = 0; i <= 23; i = i + 2) {
      temp.add(hour[i]);
    }
    return temp;
  }

  static String changeText(String text) {
    Map _map = Constants.MAPTEXT;
    if (_map.containsKey(text)) {
      return utf8convert(_map[text]);
    }
    return utf8convert(text);
  }

  static List Forecast24(List listacompleta, String data) {
    List _temp_01 = [];
    List _temp_02 = [];
    List<dynamic> listamenor =
        listacompleta.map((data) => data['hour']).toList();
    listamenor.forEach((element) {
      _temp_01.addAll(element);
    });
    _temp_01.forEach((element) {
      _temp_02.add({
        'time': element['time'],
        'temp_c': element['temp_c'],
        'icon': element['condition']['icon'],
      });
    });
    int hora = int.parse(HourSmall(data));
    List temp_03 = _temp_02.sublist(hora, hora + 24);
    List resultado = [];
    int i = 0;
    temp_03.forEach((element) {
      if (i % 2 == 0) {
        resultado.add(element);
      }
      i++;
    });

    return resultado;
  }
}
