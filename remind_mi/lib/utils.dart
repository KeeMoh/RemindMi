import 'package:flutter/material.dart';


// a revoir
class Utils {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();

  showSnackBar(String? text) { //normalement en static
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
