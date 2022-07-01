import 'package:app/firebase_options.dart';
import 'package:app/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web
  );

  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinterest Clone',
      theme: ThemeData(),
      home: Navigator(
        pages: [
          MaterialPage(
            key: ValueKey('loginPage'),
            child: LoginPage()
          )
        ],
        onPopPage: (route, result) {
          return route.didPop(result);
        },
      )
    );
  }
}