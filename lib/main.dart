import 'package:flutter/material.dart';
import 'package:movies/helpers/app_colors.dart';
import 'package:movies/screens/list_movies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ez_localization/ez_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  EzLocalizationDelegate ezLocalization = EzLocalizationDelegate(supportedLocales: [Locale('es')]); // The first language is your default language.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: ezLocalization.localizationDelegates,
      supportedLocales: ezLocalization.supportedLocales,
      localeResolutionCallback: ezLocalization.localeResolutionCallback,
      title: 'Movies',
      theme: ThemeData(
          primaryTextTheme: TextTheme(
              headline6: TextStyle(
                  color: Colors.white
              )
          ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: AppColors.backColor,
        primaryColor:Color(0xff232636)
      ),
      home: ListMovies(),
    );
  }
}
