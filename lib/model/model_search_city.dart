// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types
class ModelSearchCity {
  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  ModelSearchCity({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory ModelSearchCity.fromMap(Map<String, dynamic> map) {
    return ModelSearchCity(
      id: map['id'] as int,
      name: map['name'] as String,
      region: map['region'] as String,
      country: map['country'] as String,
      lat: map['lat'] as double,
      lon: map['lon'] as double,
      url: map['url'] as String,
    );
  }
}
