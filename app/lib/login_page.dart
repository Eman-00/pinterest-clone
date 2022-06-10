import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pinterest'),
      ),
    );
  }

}