import 'package:flutter/material.dart';
import 'package:personal/SplashScreen.dart';
import 'package:personal/CARDS/pages/PasswordHomepage.dart';
import 'package:personal/home.dart';

import 'package:personal/SignInSignUp/SignIn.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:personal/SETTINGS/SettingsPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
  // This widget is the root of your application.

}
class _MyAppState extends State<MyApp> {
  int launch = 0;
  bool loading = true;
  int primarycolorCode;
  Color primaryColor = Colors.deepPurple;

  checkPrimaryColr() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    primarycolorCode = prefs.getInt('primaryColor') ?? 0;

    if (primarycolorCode != 0) {
      setState(() {
        primaryColor = Color(primarycolorCode);
      });
    }
  }




  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    launch = prefs.getInt("launch") ?? 0;

    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';

    if (prefs.getInt('primaryColor') == null) {
      await prefs.setInt('primaryColor', 0);
    }

    if (launch == 0 && masterPass == '') {
      await prefs.setInt('launch', launch + 1);
      await prefs.setInt('primaryColor', 0);
      // await prefs.setBool('enableDarkTheme', false);
    }

    setState(() {
      loading = false;
    });
  }


  @override
  void initState() {
    checkPrimaryColr();
    checkFirstSeen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    checkPrimaryColr();
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        fontFamily: "Title",
        primaryColor: primaryColor,
        accentColor: Color(0xffe040fb),

        // primaryColor: Color(0xff5153FF),
        // primaryColorDark: Color(0xff0029cb),
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PERSONAL SECURE',
        theme: theme,
        home: loading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : launch == 0
            ? SplashScreen()
            : LoginUserPage(),
      ),
    );
  }
}

