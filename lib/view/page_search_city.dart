import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant/constants.dart';
import '../model/model_search_city.dart';
import '../provider/app_provider.dart';
import '../service/firebase_service.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PageSearchCity extends StatefulWidget {
  const PageSearchCity({super.key});

  @override
  State<PageSearchCity> createState() => _PageSearchCityState();
}

class _PageSearchCityState extends State<PageSearchCity> {
  TextEditingController cityController = TextEditingController();
  String city = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Previão do tempo da sua cidade',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: cityController,
                onChanged: (value) {
                  setState(() {
                    city = value;
                    Provider.of<AppProvider>(context, listen: false)
                        .getSearchCity(value, false);
                  });
                },
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: 300,
                  child: Consumer<AppProvider>(
                    builder: (context, value, child) {
                      List<ModelSearchCity> listCity = value.listSearchCity;
                      return cityController.text.isEmpty
                          ? Container()
                          : ListView.builder(
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: listCity.length,
                              itemBuilder: (context, index) {
                                final dataCity = listCity[index];
                                return ListTile(
                                  leading: Text(
                                      '${dataCity.name} - ${dataCity.country}'),
                                  onTap: () async {
                                    FirebaseService()
                                        .saveCitySearch(dataCity.name);
                                    FirebaseService().setHistory(dataCity.name);
                                    cityController.clear();
                                    Navigator.pushReplacementNamed(
                                        context, '/');
                                    print('passou aqui');
                                  },
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
              const Divider(thickness: 0.9),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Constants.BACKGROUND_NIGHT,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  height: 30,
                  child: const Center(
                    child: Text(
                      'Histórico',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 500,
                child: StreamBuilder<Map<String, dynamic>>(
                  stream: FirebaseService().getHistoryStream(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('tem erro: ${snapshot.error}');
                    }
                    if (snapshot.hasData) {
                      final historico = snapshot.data as Map<String, dynamic>;
                      List listHistorico = historico['locais'];
                      listHistorico = listHistorico.reversed.toList();

                      return SingleChildScrollView(
                        child: ListView.builder(
                          primary: false,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: listHistorico.length,
                          itemBuilder: (context, index) {
                            final dataCity = listHistorico[index];
                            return Column(
                              children: [
                                const Divider(thickness: 0.9),
                                Slidable(
                                  key: ValueKey<int>(listHistorico.length),
                                  startActionPane: ActionPane(
                                      motion: const ScrollMotion(),
                                      children: [
                                        // A SlidableAction can have an icon and/or a label.
                                        SlidableAction(
                                          onPressed: (context) {
                                            FirebaseService()
                                                .deleteHistory(dataCity);
                                          },
                                          backgroundColor: const Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ]),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ListTile(
                                      
                                      
                                      onTap: ()  {

                     
                                        FirebaseService()
                                            .saveCitySearch(dataCity);
                                        Navigator.pushReplacementNamed(
                                            context, '/');
                                      },
                                      leading: Text(dataCity),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
