import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/RoundIconButton.dart';
import 'package:flash_chat/components/RoundedButton.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'login_screen.dart';

final _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

FirebaseUser loggedUser;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'Welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  bool loading = true;

  Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    //Tween color animation!
    /*animation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);*/

    //controller.forward();

    //Loop Animation!
    /*animation.addStatusListener((status){
      if(status == AnimationStatus.completed){
        controller.reverse(from: 1.0);
      }else if(status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });*/

    /*controller.addListener(() {
      setState(() {
        print(animation.value);
      });
    });*/
    fetchUser();

  }

  void fetchUser() async {
    loggedUser = await checkUser();
    setState(() {
      loading = false;
      if (loggedUser != null) {
        startChat();
      }
    });
  }

  void startChat() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushNamed(
          context,ChatScreen.id,arguments: {'user': loggedUser});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<FirebaseUser> checkUser() async {
    FirebaseUser currentUser = await _auth.currentUser();
    print('User -> $currentUser');
    return currentUser;
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: kLogoTag,
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60,
                    ),
                  ),
                ),
                TyperAnimatedTextKit(
                  displayFullTextOnTap: true,
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
            Visibility(
                visible: loading && loggedUser == null,
                child: CircularProgressIndicator()),
            Visibility(
              visible: !loading && loggedUser == null,
              child: Column(
                children: <Widget>[
                  RoundIconButton(
                      onClick: () {
                        signInWithGoogle().whenComplete(() {
                          startChat();
                        });
                      },
                      elevation: 3,
                      color: Colors.blueAccent,
                      iconcolor: Colors.white,icon: FontAwesome5Brands.google),
/*
                  RoundedButton(
                    color: Colors.lightBlueAccent,
                    text: 'Login',
                    onPress: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                  ),
                  RoundedButton(
                    color: Colors.blueAccent,
                    text: 'Register',
                    onPress: () {
                      Navigator.pushNamed(context, RegistrationScreen.id);
                    },
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
