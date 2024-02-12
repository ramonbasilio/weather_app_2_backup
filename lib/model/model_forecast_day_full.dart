// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../utils/utils.dart';

class ForecastDayFull {
  final Map location;
  final Map current;
  final Map forecast;
  final List forecastday;
  final String temp;
  final String tempMax;
  final String tempMin;
  final String linkIcon;
  final String city;
  final String state;
  final String country;
  final String text;
  final String humidity;
  final String rain;
  final String wind;
  final String lastUpdated;
  final String lastUpdated_2;
  final bool isDay; 

  ForecastDayFull({
    required this.location,
    required this.current,
    required this.forecast,
    required this.forecastday,
    required double temp,
    required double tempMax,
    required double tempMin,
    required this.linkIcon,
    required this.city,
    required this.state,
    required this.country,
    required String text,
    required int humidity,
    required int rain,
    required double wind,
    required String lastUpdated,
    required int isDay,
    required this.lastUpdated_2,
  })  : text = Utils.utf8convert(text),
        temp = temp.toInt().toString(),
        tempMax = tempMax.toInt().toString(),
        tempMin = tempMin.toInt().toString(),
        humidity = humidity.toString(),
        rain = rain.toString(),
        wind = wind.toString(),
        lastUpdated = Utils.DataFormated(lastUpdated),
        isDay = isDay == 0 ? true : false;

  factory ForecastDayFull.fromMap(Map<String, dynamic> map) {
    return ForecastDayFull(
      location: map['location'] as Map,
      current: map['current'] as Map,
      forecast: map['forecast'] as Map,
      forecastday: map['forecast']['forecastday'],
      temp: map['current']['temp_c'],
      tempMax: map['forecast']['forecastday'][0]['day']['maxtemp_c'],
      tempMin: map['forecast']['forecastday'][0]['day']['mintemp_c'],
      humidity: map['current']['humidity'],
      linkIcon: map['current']['condition']['icon'],
      city: map['location']['name'],
      state: map['location']['region'],
      country: map['location']['country'],
      text: map['current']['condition']['text'],
      rain: map['forecast']['forecastday'][0]['day']['daily_chance_of_rain'],
      wind: map['current']['wind_kph'],
      lastUpdated: map['current']['last_updated'],
      lastUpdated_2: map['current']['last_updated'],
      isDay: map['current']['is_day'],
    );
  }
}
