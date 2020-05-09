import 'package:flutter/material.dart';
import 'package:supir/index.dart';
import 'package:supir/screens/main_screen.dart';

void main() {
  runApp(Supir());
}

class Supir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Supir',
      debugShowCheckedModeBanner: false,
     initialRoute: Index.id,
        routes: {
          Index.id: (context) => Index(
            screens: <Widget>[
              MainScreen()
              //Announcement(),
              //UserMessages(),
              //Contacts(),
            ],
          ),
          MainScreen.id: (context) => MainScreen()
        },
    );
  }
}
