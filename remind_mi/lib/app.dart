import 'package:flutter/material.dart';
import 'package:remind_mi/pages/calendar_page.dart';
import 'package:remind_mi/pages/home_page.dart';
import 'package:remind_mi/pages/todo_list_page.dart';
import 'package:remind_mi/pages/main_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// ignore: must_be_immutable
class RemindMiApp extends StatelessWidget {
  MaterialColor primarycolor = MaterialColor(
    const Color.fromRGBO(29, 36, 50, 1.0).value,
    const <int, Color>{
      50: Color.fromRGBO(29, 36, 50, 0.1),
      100: Color.fromRGBO(29, 36, 50, 0.2),
      200: Color.fromRGBO(29, 36, 50, 0.3),
      300: Color.fromRGBO(29, 36, 50, 0.4),
      400: Color.fromRGBO(29, 36, 50, 0.5),
      500: Color.fromRGBO(29, 36, 50, 0.6),
      600: Color.fromRGBO(29, 36, 50, 0.7),
      700: Color.fromRGBO(29, 36, 50, 0.8),
      800: Color.fromRGBO(29, 36, 50, 0.9),
      900: Color.fromRGBO(29, 36, 50, 1),
    },
  );

  MaterialColor secondarycolor = MaterialColor(
    const Color.fromRGBO(248, 228, 148, 1.0).value,
    const <int, Color>{
      50: Color.fromRGBO(248, 228, 148, 0.1),
      100: Color.fromRGBO(248, 228, 148, 0.2),
      200: Color.fromRGBO(248, 228, 148, 0.3),
      300: Color.fromRGBO(248, 228, 148, 0.4),
      400: Color.fromRGBO(248, 228, 148, 0.5),
      500: Color.fromRGBO(248, 228, 148, 0.6),
      600: Color.fromRGBO(248, 228, 148, 0.7),
      700: Color.fromRGBO(248, 228, 148, 0.8),
      800: Color.fromRGBO(248, 228, 148, 0.9),
      900: Color.fromRGBO(248, 228, 148, 1),
    },
  );

  RemindMiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //scaffoldMessengerKey: Utils.messengerKey, //a mettre en place quand utils sera corrigé
      title: 'RemindMi',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: secondarycolor,
        scaffoldBackgroundColor: primarycolor,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    );
  }
}
