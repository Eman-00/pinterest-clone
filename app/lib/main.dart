import 'package:app/login_page.dart';
import 'package:flutter/material.dart';

void main() {
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