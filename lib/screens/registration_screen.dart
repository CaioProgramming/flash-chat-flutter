import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/RoundedButton.dart';
import 'package:flash_chat/components/TextFieldDecoration.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'Registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  String email,password;
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: kLogoTag,
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: kFormTextStyle,
                onChanged: (value) {
                  email = value;
                },
                decoration:  TextFieldDecoration(
                    hintText: 'Enter your e-mail',
                    borderRadius: kBorderRadius,
                    defaultColor: Colors.blueGrey,
                    enabledColor: Colors.lightBlueAccent,
                    focusedColor: Colors.blueAccent).decoration(),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  style: kFormTextStyle,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: TextFieldDecoration(
                      hintText: 'Enter your password',
                      borderRadius: kBorderRadius,
                      defaultColor: Colors.grey,
                      enabledColor: Colors.lightBlueAccent,
                      focusedColor: Colors.blueAccent).decoration()),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Register',
                color: Colors.blueAccent,
                onPress: () async {
                  loading(true);
                  print('email $email');
                  print('password $password');
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser != null){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }finally{
                    loading(false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  void loading(bool isload){
    setState(() {
      showSpinner = isload;
    });
  }
}
