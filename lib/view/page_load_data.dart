// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:weaher_app/constant/constants.dart';
import 'package:weaher_app/model/model_forecast_day_full.dart';
import 'package:weaher_app/provider/app_provider.dart';

import 'package:weaher_app/view/page_inicial_new.dart';
import 'package:weaher_app/view/page_search_city.dart';

import '../service/http_service.dart';

class PageLoadData extends StatefulWidget {
  const PageLoadData({super.key});

  @override
  State<PageLoadData> createState() => _PageLoadDataState();
}

class _PageLoadDataState extends State<PageLoadData> {


  void reload() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

   drawer: SafeArea(
     child: Consumer<AppProvider>(builder: (context, value, child) => 
       Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Constants.BACKGROUND_NIGHT,
                ),
                child: Text('Previsão do tempo', style: TextStyle(color: Constants.BACKGROUND_DAY, fontSize: 40),textAlign: TextAlign.center, ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add,
                ),
                title: const Text('Procurar cidade'),
                onTap: () {
                  value.resetCity();
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(builder:(context) => PageSearchCity()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                ),
                title: const Text('Cidades favoritas'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
     ),
   ),
      backgroundColor: Constants.BACKGROUND_DAY,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {});
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Consumer<AppProvider>(
              builder: (context, value, child) => Center(
                child: FutureBuilder<ForecastDayFull>(
                  future: HttpService().GetWeatherCurrent(value.citySaved),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        height: 600,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Image.asset(
                              'Assets/NewAssets/day/warning.png',
                              height: 100,
                              width: 100,
                            ),
                            Text(
                              'Opsss...${snapshot.error}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasData) {
                      ForecastDayFull dataWeather =
                          snapshot.data as ForecastDayFull;

                      return PageInicialNew(
                          dataWeather: dataWeather, reload: reload);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
