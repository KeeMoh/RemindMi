import 'package:flutter/material.dart';
import 'package:remind_mi/pages/main_page.dart';
import 'package:remind_mi/utils/charter.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// ignore: must_be_immutable
class RemindMiApp extends StatelessWidget {
  const RemindMiApp({super.key});

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
        primarySwatch: Charter.secondarycolor,
        scaffoldBackgroundColor: Charter.primarycolor,
      ),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
    );
  }
}
