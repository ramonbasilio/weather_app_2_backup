// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weaher_app/utils/geolocator.dart';
import 'package:weaher_app/utils/utils.dart';

import '../constant/constants.dart';
import '../model/model_forecast_day_full.dart';
import '../provider/app_provider.dart';

class PageInicialNew extends StatefulWidget {
  final ForecastDayFull dataWeather;
  final Function reload;
  const PageInicialNew(
      {required this.dataWeather, required this.reload, super.key});

  @override
  State<PageInicialNew> createState() => _PageInicialNewState();
}

class _PageInicialNewState extends State<PageInicialNew> {
  late Color fontColor;
  late List hour;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    hour = Utils.Forecast24(
        widget.dataWeather.forecastday, widget.dataWeather.lastUpdated_2);
    if (!widget.dataWeather.isDay) {
      fontColor = Constants.BACKGROUND_NIGHT;
    } else {
      fontColor = Constants.BACKGROUND_DAY;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    Consumer<AppProvider>(
      builder: (context, value, child) => SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) => Container(
            color: !widget.dataWeather.isDay
                ? Constants.BACKGROUND_DAY
                : Constants.BACKGROUND_NIGHT,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            focusColor: Colors.orange,
                            hoverColor: Colors.orange,
                            highlightColor: Colors.orange,
                              splashColor: Colors.orange,

                              onPressed: () async {
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
                                GeolocatorClass _geolocatorclass =
                                    GeolocatorClass();
                                Position myposition =
                                    await _geolocatorclass.getPosition();
                                String loc =
                                    '${myposition.latitude},${myposition.longitude}';
                                print('Minha localização atual: $loc');
                                value.getSearchCity(loc, true);
                                value.getCitySaved(loc);
                                widget.reload();
                              },
                              icon: Icon(Icons.location_on),
                              iconSize: 40),
                          Text(
                            widget.dataWeather.location['name'],
                            style: TextStyle(fontSize: 50, color: fontColor),
                          ),
                          Text(
                              '${widget.dataWeather.location['region']} - ${widget.dataWeather.location['country']}',
                              style: TextStyle(fontSize: 20, color: fontColor)),
                        ],
                      ),
                      // SizedBox(
                      //   height: 50,
                      //   child: Image.asset(
                      //     'Assets/${Utils.NightOrDay(widget.dataWeather.linkIcon)}/${Utils.NameImage(widget.dataWeather.linkIcon)}',
                      //     fit: BoxFit.fill,
                      //   ),
                      // ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${widget.dataWeather.temp}°',
                                style:
                                    TextStyle(fontSize: 150, color: fontColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text('${widget.dataWeather.tempMax}°',
                                      style: TextStyle(
                                          fontSize: 30, color: fontColor)),
                                  Text('${widget.dataWeather.tempMin}°',
                                      style: TextStyle(
                                          fontSize: 30, color: fontColor)),
                                ],
                              )
                            ],
                          ),
                          Text(
                            widget.dataWeather.text,
                            style: TextStyle(fontSize: 20, color: fontColor),
                          )
                        ],
                      ),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: SizedBox(
                          height: 400,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        'Assets/Comum_icons/humidity.png',
                                        height: 50,
                                      ),
                                      Text(
                                        'Umidade \n${widget.dataWeather.humidity}%',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: fontColor),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        'Assets/Comum_icons/umbrella.png',
                                        height: 50,
                                      ),
                                      Text(
                                        'Chuva \n${widget.dataWeather.rain}%',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: fontColor),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        'Assets/Comum_icons/wind.png',
                                        height: 50,
                                      ),
                                      Text(
                                        'Vento \n${widget.dataWeather.wind} Km/h',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 18, color: fontColor),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 0),
                                child: Divider(
                                  color: fontColor,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Previsão 24 horas',
                                  style:
                                      TextStyle(fontSize: 18, color: fontColor),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)),
                                    border: Border.all(width: 0.3)),
                                height: 180,
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  controller: _controller,
                                  thickness: 5,
                                  child: ListView.builder(
                                    controller: _controller,
                                    physics: BouncingScrollPhysics(
                                        decelerationRate:
                                            ScrollDecelerationRate.fast),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: hour.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: !widget.dataWeather.isDay
                                                ? Constants.BACKGROUND_DAY
                                                : Constants.BACKGROUND_NIGHT,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          width: 60,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${hour[index]['temp_c'].toInt().toString()}°',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 30,
                                                  color: fontColor,
                                                ),
                                              ),
                                              Image.asset(
                                                'Assets/${Utils.NightOrDay(hour[index]['icon'])}/${Utils.NameImage(hour[index]['icon'])}',
                                                fit: BoxFit.fill,
                                                height: 40,
                                              ),
                                              Text(
                                                '${Utils.HourFormated(hour[index]['time'])}:00',
                                                style: TextStyle(
                                                    color: fontColor,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  bottom: 5,
                  child: Text(
                    'Atualizado em: ${widget.dataWeather.lastUpdated}',
                    style: TextStyle(
                      color: fontColor,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                        // value.resetCity();
                        // Navigator.pushNamed(context, '/pageSearchCity');
                      },
                      icon: const Icon(Icons.menu),
                      color: fontColor,
                      iconSize: 40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
