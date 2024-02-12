// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:weaher_app/utils/utils.dart';

class PageForecastDay extends StatefulWidget {
  final List forecast;
  const PageForecastDay({required this.forecast, super.key});

  @override
  State<PageForecastDay> createState() => _PageForecastDayState();
}

class _PageForecastDayState extends State<PageForecastDay> {
  late List hour;

  @override
  void initState() {
    hour = Utils.HourlyForecast(widget.forecast);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Previsão 24 horas - ${Utils.DataFormatedResumed(widget.forecast[0]['time'])}',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: hour.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              height: 100,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                tileColor: Colors.green.shade100,
                trailing: Text(
                  '${Utils.HourFormated(hour[index]['time'])}:00',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w300),
                ),
                title: Column(
                  children: [
                    Text(
                      '${hour[index]['temp_c'].toString()}°',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    ),
                    Text(
                      Utils.changeText(hour[index]['condition']['text']),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                leading: Image.asset(
                  'Assets/${Utils.NightOrDay(hour[index]['condition']['icon'])}/${Utils.NameImage(hour[index]['condition']['icon'])}',
                  fit: BoxFit.fill,
                  height: 60,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
