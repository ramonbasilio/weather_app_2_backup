import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weaher_app/constant/constants.dart';
import 'package:weaher_app/provider/app_provider.dart';
import 'package:weaher_app/view/page_inicial_new.dart';
import 'package:weaher_app/view/page_search_city.dart';
import 'package:weaher_app/view/page_load_data.dart';
import 'package:weaher_app/view/page_test.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (_) => AppProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Constants.BACKGROUND_NIGHT), //(Theme.of(context).textTheme) 
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme), 
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PageLoadData(),
        '/pageSearchCity': (context) => const PageSearchCity(),
        
      },
    );
  }
}
