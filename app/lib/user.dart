import 'package:app/error_message_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class User {
  static User instance = User._User();

  User._User();

  String? get name => FirebaseAuth.instance.currentUser!.displayName;
  
  String? get email => FirebaseAuth.instance.currentUser!.email;

  Future<void> setName(String name) => FirebaseAuth.instance.currentUser!.updateDisplayName(name);
  
  Future<void> setEmail(String email) => FirebaseAuth.instance.currentUser!.updateEmail(email);
  
  Future<void> setPassword(String password) => FirebaseAuth.instance.currentUser!.updatePassword(password);

  Future<String?> createAccount(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
      );
      
      await setName(name);
      
    } on FirebaseAuthException catch(e) {
      return Future.value(ErrorMessageHandler(e.code).message);
    }
    return null;
  }

  void deleteAccount() {
    try {
      FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch(e) {
      print(e.code);
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );
    } on FirebaseAuthException catch(e) {
      return Future.value(ErrorMessageHandler(e.code).message);
    }
    return null;
  }

  void signOut() {
    try {
      FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }

  // if state is false, it means the user is signed out, else the user is signed in.
  void checkAuthState(void Function(bool state) getAuthState) {
    try {
      FirebaseAuth.instance.userChanges().listen((user) {
          var state = user == null ? false : true;
          getAuthState(state);
      });
    }
    on FirebaseAuthException catch (e){
      print(e.code);
    } catch (e) {
      print(e);
    }
  }
}