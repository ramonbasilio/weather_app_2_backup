// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Constants {
  static String URLBASE = 'api.weatherapi.com';
  static String URLSEARCH = '/v1/search.json';
  static String URLFORECAST = '/v1/forecast.json';
  static String KEYAPI = 'cf6742caba224882a0303024232104';

  static Color BACKGROUND_DAY = const Color(0xffe5ecf4);
  static Color BACKGROUND_NIGHT = const Color(0xff313745);

  static TextStyle GOOGLE_FONTS_NUNITO = GoogleFonts.nunito();

  static Color FONT_COLOR_DAY = Colors.black;
  static Color FONT_COLOR_NIGHT = Colors.white;

  static Map<String, String> MAPTEXT = {
    'Aguaceiros fracos': 'Chuva fraca',
    'Possibilidade de chuva irregular': 'Possibilidade de chuva fraca',
  };
}
