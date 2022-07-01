import 'user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  String tmpName = "", tmpEmail = "", tmpPassword = "";
  var isSignedIn = false;

  @override
  void initState() {
    super.initState();
    
    User.instance.checkAuthState((state) {
      print("checking authentication state...");
      if(isSignedIn != state) setState(() {
        isSignedIn = state;
        print("auth state changed to: ${state == true? "signed in" : "signed out"}"
        );
      });
    });
  }

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
              onPressed: ()=> showDialog(context: context, barrierDismissible: false, builder: (context) => dialogBuilder(
                  context: context,
                  onActionPressed: () {
                    User.instance.signIn(tmpEmail, tmpPassword);
                    Navigator.pop(context);
                  },
                  actionText: "Login"
              )),
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
              onPressed: ()=> showDialog(context: context, barrierDismissible: false, builder: (context) => dialogBuilder(
                  context: context,
                  userNameTextField: true,
                  onActionPressed: () async {
                      User.instance.createAccount(tmpName, tmpEmail, tmpPassword);
                      Navigator.pop(context);
                    },
                  actionText: "Sign up",
              )),
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
      body: isSignedIn == true ? Column(
        children: [
          Text(
          "name: ${User.instance.name}\n"
          "email: ${User.instance.email}"
          ),
          TextButton(onPressed: ()=> User.instance.signOut(), child: Text("sign out")),
          TextButton(onPressed: ()=> User.instance.deleteAccount(), child: Text("Delete"))
        ],
      ) : Text("Signed out")
    );
  }

  AlertDialog dialogBuilder({required BuildContext context, required void Function() onActionPressed, required String actionText, bool userNameTextField = false}) {
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
              if(userNameTextField == true) TextField(
                onChanged: (value) => setState(()=>tmpName = value),
                decoration: InputDecoration(
                  hintText: "username"
                ),
              ),
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