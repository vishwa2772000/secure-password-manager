import 'package:flutter/material.dart';

import 'package:personal/WelcomePage.dart';

class SplashScreen extends StatefulWidget {
  @override

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), ()
    {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        // MaterialPageRoute(builder: (context) => ChatListScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          color: Colors.deepPurple,
          height: 400,
          width: 400,
          image: AssetImage("assets/ic_wa.png"),
        ),
      ),
    );
  }
}
