import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';



void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedUser;


  void getUser() async {
    loggedUser = await  _auth.currentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          body1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: loggedUser == null ? WelcomeScreen.id: ChatScreen.id,
      routes: {
        WelcomeScreen.id:(context) =>WelcomeScreen(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        ChatScreen.id:(context) => ChatScreen()
      },
    );
  }
}
