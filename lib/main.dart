import 'package:flutter/material.dart';

import 'Screen/splash_screen.dart';


void main() {
 //WidgetsFlutterBinding.ensureInitialized();
  runApp( const TaskManager());
}

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 30),
        ),
        inputDecorationTheme: const InputDecorationTheme(
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent)),

            ///Focous e borderSide.none dele kicuy Ashbe na
            hintStyle: TextStyle(color: Colors.black26)),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        primaryColor: Colors.green,
        brightness: Brightness.light,

        /* elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                  foregroundColor: MaterialStatePropertyAll(Colors.white)))*/
      ),
      home: const SplashScreen(),
    );
  }
}
