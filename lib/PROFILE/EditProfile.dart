import 'package:personal/SignInSignUp/data/database_Helper.dart';
import 'package:personal/SignInSignUp/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:personal/CARDS/pages/PasswordHomepage.dart';
import 'package:personal/home.dart';
import 'package:personal/SignInSignUp/data/database_Helper.dart';
import 'package:personal/SignInSignUp/models/User.dart';
import 'package:personal/SignInSignUp/SignIn.dart';

class EditProfile extends StatefulWidget{
  @override
  EditProfileState createState() =>EditProfileState();
  Brightness brigntness = Brightness.light;

  EditProfile({this.brigntness});

}

class  EditProfileState extends State<EditProfile>
{

  final  _formkey=GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text('Credits',style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  //1

                  Padding(
                    padding: const EdgeInsets.only(left:5.0,right: 5.0,top: 15.0),
                   child:  Text("Credit of developing and deploying this app goes to:",
                       textAlign: TextAlign.start,
                       style: TextStyle(
                           fontFamily: 'GoogleSansRegular',
                           fontSize: 19,
                           fontWeight: FontWeight.bold,
                           color: Colors.deepPurple)),
                  ),
                  SizedBox(height: 15,),
                  //2
                  Padding(
                    padding: const EdgeInsets.only(left:5.0,right: 5.0,top:10.0),
                    child: Container(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                           Text("iMSc(IT) Pprogramme,",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontFamily: 'GoogleSansRegular',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          )),
                          SizedBox(height: 10,),
                          Text("Faculty of Computer Applications and Information Technology,",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  )),
                          SizedBox(height: 10,),
                          Text("GLS University.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  )),
                          SizedBox(height: 10,),

                        ],
                      ) ,
                    ),
                  ),
                  SizedBox(height: 10,),
                  //3
                  Padding(
                    padding: const EdgeInsets.only(left:5.0,right: 5.0,top:15.0),
                    child: Container(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("App Developers",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple)),
                          SizedBox(height: 10,),
                          Text("Ms. Sakshi Rana",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  )),
                          Text("Ms. Vishwa Shah",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  )),
                          Text("Ms. Amisha Koshti",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                 )),


                        ],
                      ) ,
                    ),
                  ),
                  SizedBox(height: 10,),
                  //4
                  Padding(
                    padding: const EdgeInsets.only(left:5.0,right: 5.0,top:15.0),
                    child: Container(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Mentors",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple)),
                          SizedBox(height: 10,),
                          Text("Dr. Harshal Arolkar",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'GoogleSansRegular',
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Prof. Vishal Narvani",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'GoogleSansRegular',
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              )),
                          Text("Prof. Jenny Kasudiya",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'GoogleSansRegular',
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                )),
                        ],
                      ) ,
                    ),
                  ),


                ],
              ))
        ],
      ),
    );


  }

}

