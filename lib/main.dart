import 'package:flutter/material.dart';
import 'package:supir/screens/main_screen.dart';
import 'package:supir/utilities/constants.dart';

void main() {
  runApp(Supir());
}

class Supir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supir',
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kDefaultBackgroundColour,
        ),
        home: MainScreen(),
    );
  }
}
