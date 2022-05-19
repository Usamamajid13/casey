import 'package:casey/enter_names_screen.dart';
import 'package:casey/results_screen.dart';
import 'package:casey/splash_screen.dart';
import 'package:casey/voting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';
import 'home_screen.dart';
import 'voting_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: pinkColor, statusBarColor: pinkColor);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return MaterialApp(
      title: 'Casey Warriors',
      debugShowCheckedModeBanner: false,
      initialRoute: splashRoute,
      routes: {
        splashRoute: (context) => const SplashScreen(),
        homeScreenRoute: (context) => const HomeScreen(),
        votingMainScreenRoute: (context) => const VotingHomeScreen(),
        enterNamesScreenRoute: (context) => const EnterNameScreen(),
        votingScreenRoute: (context) => const VotingScreen(),
        seeResultsScreenRoute: (context) => const ResultScreen(),
      },
    );
  }
}
