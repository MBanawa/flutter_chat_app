import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_chat_app/components/rounded_long_button.dart';

import 'package:flutter_chat_app/screens/login_screen.dart';
import 'package:flutter_chat_app/screens/registration_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation logoAnimation;
  Animation colorAnimation;
  Animation singleButtonAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    logoAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.decelerate,
    );

    colorAnimation = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.white,
    ).animate(controller);

    singleButtonAnimation = ColorTween(
      begin: Colors.deepOrange,
      end: Colors.orange.shade300,
    ).animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAnimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: logoAnimation.value * 100,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TypewriterAnimatedTextKit(
                  speed: Duration(milliseconds: 500),
                  text: ['Dialogo'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            RoundedLongButton(
              color: singleButtonAnimation.value,
              title: 'Log In',
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedLongButton(
              color: Colors.deepOrange,
              title: 'Register',
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}

