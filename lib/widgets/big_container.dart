// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weaher_app/model/model_forecast_day_full.dart';
import 'package:weaher_app/utils/geolocator.dart';
import 'package:weaher_app/utils/utils.dart';

import '../provider/app_provider.dart';

class BigContainer extends StatefulWidget {
  final ForecastDayFull dataWeather;
  final Function reload;
  const BigContainer({
    super.key,
    required this.reload,
    required this.dataWeather,
  });

  @override
  State<BigContainer> createState() => _BigContainerState();
}

class _BigContainerState extends State<BigContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (BuildContext context, value, Widget? child) => Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              widget.reload();
            },
            child: Column(
              children: [
                Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 159, 209, 250)
                            .withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(
                            0, 0.1), // Altere os valores para ajustar o brilho
                      ),
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [
                          0.2,
                          0.5,
                          0.8
                        ],
                        colors: [
                          Colors.blue, // Azul inicial
                          Colors.lightBlue, // Azul mais claro
                          Colors.blueAccent, // Azul brilhante
                        ]),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () async {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.amber.shade100,
                                content: const Text(
                                  'Carregando localização atual...',
                                  style: TextStyle(color: Colors.black),
                                ),
                                duration: const Duration(seconds: 3),
                              ),
                            );
                            GeolocatorClass _geolocatorclass = GeolocatorClass();
                            Position myposition =
                                await _geolocatorclass.getPosition();
                            String loc =
                                '${myposition.latitude},${myposition.longitude}';
                            print('Minha localização atual: $loc');
                            value.getSearchCity(loc, true);
                            value.getCitySaved(loc);
                            widget.reload();
                          },
                          child: Column(
                            children: [
                              const Icon(Icons.location_on),
                              Text(
                                widget.dataWeather.location['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${widget.dataWeather.location['region']} - ${widget.dataWeather.location['country']}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: Image.asset(
                          'Assets/${Utils.NightOrDay(widget.dataWeather.linkIcon)}/${Utils.NameImage(widget.dataWeather.linkIcon)}',
                          fit: BoxFit.fill,
                        ),
                      ),
          
                      // SizedBox(
                      //   height: 100,
                      //   child: Image.asset(
                      //     'Assets/NewAssets/day/230.png',
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.dataWeather.temp,
                                style: const TextStyle(
                                    shadows: [
                                      Shadow(
                                          offset: Offset(0, 0),
                                          blurRadius: 10,
                                          color: Colors.white),
                                    ],
                                    fontSize: 200,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 100,
                                child: Image.asset(
                                  'Assets/NewAssets/day/thermometer.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            Utils.utf8convert(
                                widget.dataWeather.current['condition']['text']),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        child: Text(
                          'Última atualização: ${Utils.utf8convert(widget.dataWeather.current['last_updated'])}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 150,
                )
              ],
            ),
          ),
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: IconButton(
          //       onPressed: () {
          //         widget.reload();
          //       },
          //       icon: const Icon(Icons.refresh_outlined),
          //       iconSize: 40),
          // ),
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
                onPressed: () {
                  value.resetCity();
                  Navigator.pushNamed(context, '/pageSearchCity');
                },
                icon: const Icon(Icons.add),
                iconSize: 40),
          )
        ],
      ),
    );
  }
}
