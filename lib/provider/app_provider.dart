// ignore_for_file: prefer_final_fields, unused_field, unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weaher_app/model/model_search_city.dart';
import 'package:weaher_app/service/http_service.dart';

import '../constant/constants.dart';
import '../service/firebase_service.dart';

class AppProvider extends ChangeNotifier {
  final _httpService = HttpService();
  bool isLoading = false;

  List<ModelSearchCity> _listSearchCity = [];
  List<ModelSearchCity> get listSearchCity => _listSearchCity;

  bool _dayOrNight = false;
  bool get dayOrNight => _dayOrNight;



  String _citySaved = '';
  String get citySaved => _citySaved;

  Future<void> getSearchCity(String city, [bool? localPosition]) async {
    _listSearchCity = await _httpService.GetSearchCity(city, localPosition);
    notifyListeners();
  }

  void getCitySaved(String city) async {
    _citySaved = city;
    notifyListeners();
  }

  void resetCity() {
    _citySaved = '';
    notifyListeners();
  }

    void getDayOrNight(bool value) {
    _dayOrNight = value;
    notifyListeners();
  }


}
