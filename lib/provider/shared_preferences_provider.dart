// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceProvider extends ChangeNotifier {
  String _local = '';
  String _localCurrent = '';
  String get localCurrent => _localCurrent;
  String get local => _local;
  
  Future<String> read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _localCurrent = prefs.getString('local').toString();
    print('Local atual: $_localCurrent');
    notifyListeners();
    return _localCurrent;
  }

  void write(String place) async {
    print('cidade salva...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Cidade atual: ${prefs.getString('local').toString()}');
    prefs.setString('local', place);
    _local = place;
    notifyListeners();
  }
}
