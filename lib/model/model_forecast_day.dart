class ForecastDay {
  final List forecastday;

  ForecastDay({
    required this.forecastday,
  });

  factory ForecastDay.fromMap(Map<String, dynamic> map) {
    return ForecastDay(
      forecastday: map['forecast']['forecastday'],
    );
  }
}
