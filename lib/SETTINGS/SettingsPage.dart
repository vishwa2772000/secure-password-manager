import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:personal/CARDS/pages/SetMasterPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:personal/SETTINGS/ChangePassword.dart';
import 'package:personal/SETTINGS/AboutUs.dart';
import 'package:personal/SETTINGS/Help.dart';
import 'package:personal/SETTINGS/RateApp.dart';
import 'package:personal/SignInSignUp/data/database_Helper.dart';
import 'package:personal/SignInSignUp/models/User.dart';
import 'package:personal/SignInSignUp/SignIn.dart';
import 'package:personal/CheckForPass.dart';

GoogleSignIn googleSignIn;
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {
  SharedPreferences prefs;
  Color selectedColor = Colors.red;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Color pickedColor;
  bool status = false;
  User user;
  Size size;
  @override
  void initState() {
    // TODO: implement initState
/*
    DatabaseHelper.instance.getUserData().then((result){
      setState(() {
        user=result;
      });
    });*/
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Settings",
          style: TextStyle(color: Colors.white),),
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Color(0xFF6F35A5),

      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: ListView(
          children: [
            InkWell(

              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CheckPass()));
                //---------------------------------------------------------------------------------------------------------------------------------------
              },
              child: ListTile(

                title: Text(
                  "Master Password",
                  style: TextStyle(
                      fontFamily: 'Title',
                      fontWeight: FontWeight.bold
                  ),
                ),
                subtitle: Text(
                  "Change your Master Password",
                  style: TextStyle(
                    fontFamily: 'Subtitle',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 15,
              thickness: 2,
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Help"),
            SizedBox(
              height: 20,
            ),
            buildAccountOptionRow(context, "Rate App"),
            SizedBox(
              height: 20,
            ),
            buildAccountOptionRow(context, "About Us"),
/*
            Divider(
              height: 15,
              thickness: 2,
            ),

            Center(
              child: OutlineButton(
                padding: EdgeInsets.symmetric(horizontal: 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                 /* logout() async {
                    await googleSignIn.signOut();
                    Navigator.of(context)
                        .pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (context) => LoginUserPage()
                      ),
                          (_) => false,
                    );
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginUserPage()));*/
                  }*/
                    /*
                  DatabaseHelper.instance.deleteUser(user.email).then((result){
                    if(result == 1)
                    {
                      Future<void> _handleSignOut() async{
                        googleSignIn.disconnect();
                      }
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginUserPage()));

                    }
                    else
                      {

                        scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("Sign out not done")));
                      }

                  });
*/
                },
                child: Text("SIGN OUT",
                    style: TextStyle(
                        fontSize: 16, letterSpacing: 2.2, color: Colors.black)),
              ),
            )*/

          ],
        ),
      ),
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Help") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Help()));
        }
        else if (title == "Rate App") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RateApp()));
        }
        else if (title == "About Us") {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AboutUs()));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

void handleBack() {
  Navigator.pop(context);
}
}
