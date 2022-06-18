import 'dart:js';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<LoginPage> {

  String tmpEmail = "", tmpPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(children: [Expanded(child: Image.asset("images/Pinterest-Logo.png"))],),
        leadingWidth: 200,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(top:10 ,bottom: 10),
            child: TextButton(
              onPressed: ()=> setState(() {
                showDialog(context: context, barrierDismissible: false, builder: (context) => dialogBuilder(
                  context: context,
                  onActionPressed: () {
                    print("login, email: ${tmpEmail}, password: ${tmpPassword}");
                  },
                  actionText: "Login"
                ));
              }), 
              child: Text(
                '  Log in  ',
                style: GoogleFonts.notoSans(),
              ),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(TextStyle(
                  foreground: Paint()..color = Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                  states.contains(MaterialState.pressed)? Color.fromARGB(255, 209, 50, 38) :
                  states.contains(MaterialState.hovered)? Color.fromARGB(255, 231, 59, 47) :
                  Colors.red
                ),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                )),
                splashFactory: NoSplash.splashFactory,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:10, left: 10, right: 40, bottom: 10),
            child: TextButton(
              onPressed: ()=> setState(() {
                showDialog(context: context, barrierDismissible: false, builder: (context) => dialogBuilder(
                  context: context,
                  onActionPressed: () {
                    print("signUp, email: $tmpEmail, password: $tmpPassword");
                  },
                  actionText: "Continue",
                ));
              }),
              child: Text(
                '  Sign up  ',
                style: GoogleFonts.notoSans(),
              ),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(TextStyle(
                  foreground: Paint()..color = Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                )),
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                  states.contains(MaterialState.pressed)? Color.fromARGB(255, 196, 195, 195) :
                  states.contains(MaterialState.hovered)? Color.fromARGB(255, 206, 205, 205) :
                  Color.fromRGBO(218, 218, 218, 1)
                ),
                shape: MaterialStateProperty.all( RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                )),
                splashFactory: NoSplash.splashFactory
              ),
            )
          )
        ],
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }

  AlertDialog dialogBuilder({required BuildContext context, required void Function() onActionPressed, required String actionText}) {
    return AlertDialog(title: Row(children: [
      Text('Welcome to Pinterest'),
      Spacer(),
      IconButton(
        onPressed: ()=> Navigator.pop(context),
        icon: Icon(Icons.close),
        splashRadius: 0.1,
      )]),
      contentPadding: EdgeInsets.fromLTRB(24, 0, 24, 24),
      content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => setState(()=>tmpEmail = value),
                decoration: InputDecoration(
                  hintText: "email"
                ),
              ),
              TextField(
                onChanged: (value) => setState(()=> tmpPassword = value),
                decoration: InputDecoration(
                  hintText: "password"
                ),
              )
      ]),
      actions: [TextButton(onPressed: onActionPressed, child: Text(actionText))]
    );
  }
}