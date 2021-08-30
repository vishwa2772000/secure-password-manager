import 'dart:ui';
import 'package:personal/SOCIAL/model/SocialModel.dart';
import 'package:personal/SOCIAL/pages/SocialHomepage.dart';
import 'package:personal/home.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:personal/SOCIAL/database/Database.dart';

import 'package:personal/random_string.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:password_strength/password_strength.dart';

class AddSocial extends StatefulWidget {
  //AddSocial({Key key}) : super(key: key);
  Function() triggerRefetch;
  Social existingNote;
  AddSocial({Key key,Function() triggerRefetch, Social existingNote})
      : super(key: key) {
    this.triggerRefetch = triggerRefetch;
    this.existingNote = existingNote;

  }

  _AddSocialState createState() => _AddSocialState();
}

class _AddSocialState extends State<AddSocial> {
  final _formKey = GlobalKey<FormState>();

  bool isDirty = false;
  bool isNoteNew = true;
  FocusNode appNameFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  Social currentNote;

  TextEditingController passwordController = TextEditingController();
  TextEditingController appNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Color pickedColor;
  var localAuth = LocalAuthentication();

  encrypt.Encrypted encrypted;
  String keyString = "";
  String encryptedString = "";
  String decryptedString = "";
  String masterPassString = "";
  int pickedIcon;

  List<Icon> icons = [
    Icon(Icons.account_circle, size: 28, color: Colors.white),
    Icon(Icons.add, size: 28, color: Colors.white),
    Icon(Icons.add_shopping_cart_outlined, size: 28, color: Colors.white),
    Icon(Icons.add_to_drive, size: 28, color: Colors.white),
    Icon(Icons.ac_unit_sharp, size: 28, color: Colors.white),
    Icon(Icons.account_balance, size: 28, color: Colors.white),
    Icon(Icons.email_sharp , size: 28, color: Colors.white),
    Icon(Icons.chat_sharp, size: 28, color: Colors.white),
    Icon(Icons. check_box_rounded, size: 28, color: Colors.white),
    Icon(Icons.group_add_outlined, size: 28, color: Colors.white),
  ];


  List<String> iconNames = [
    "Icon 1",
    "Icon 2",
    "Icon 3",
    "Icon 4",
    "Icon 5",
    "Icon 6",
    "Icon 7",
    "Icon 8",
    "Icon 9",
    "Icon 10",
  ];

  List<Color> colors = [
    Colors.red,
    // Color(0xffd5563a),
    Color(0xffcf5a3b),
    // Color(0xffca5d3c),
    // Color(0xffc6603d),
    // Color(0xffc0643d),
    Color(0xffba673e),
    // Color(0xffb66a3f),
    // Color(0xffb36c3f),
    // Color(0xffaf6e40),
    Color(0xffa87341),
    // Color(0xffa47642),
    Color(0xffa07842),
    // Color(0xff9b7b43),
    // Color(0xff967f44),
    // Color(0xff908245),
    Color(0xff8b8646),
    // Color(0xff858a47),
    Color(0xff808d47),
    // Color(0xff799249),
    // Color(0xff769349),
    // Color(0xff72964a),
    Color(0xff6d994a),
    // Color(0xff6c9a4a),
    // Color(0xff659e4c),
    // Color(0xff639f4c),
    Color(0xff5ea34d),
    // Color(0xff5ba44d),
    Color(0xff58a64e),
    // Color(0xff53aa4e),
    Colors.green
  ];

  // Future<Null> getMasterPass() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String masterPass = prefs.getString('master') ?? "";
  //   masterPassString = masterPass;
  // }

  Future<Null> getMasterPass() async {
    final storage = new FlutterSecureStorage();
    String masterPass = await storage.read(key: 'master') ?? '';
    masterPassString = masterPass;
  }

  authenticate() async {
    try {
      var localAuth = LocalAuthentication();
      print(await localAuth.getAvailableBiometrics());
      bool didAuthenticate = await localAuth.authenticateWithBiometrics(
        localizedReason: 'Please authenticate to add new password',
      );

      print(didAuthenticate);

      if (didAuthenticate == false) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => Home()),
            (Route<dynamic> route) => false);
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notAvailable) {
        // Handle this exception here.
      }
    }
  }

  double passwordStrength = 0.0;
  Color passwordStrengthBarColor = Colors.red;
  bool obscureText = true;
  String show_hide = 'Show Password';
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    pickedColor = Colors.deepPurple;
    getMasterPass();
    pickedIcon = 0;
    // authenticate();
    super.initState();
    if (widget.existingNote == null) {
      currentNote = Social(
          appName: '', userName: '', password: '');
      isNoteNew = true;
    } else {
      currentNote = widget.existingNote;
      isNoteNew = false;
    }
    appNameController.text = currentNote.appName;
    userNameController.text = currentNote.userName;
    passwordController.text = currentNote.password;
  }
  /*checkPassStrength(String pass) {
    setState(() {
      passwordStrength = estimatePasswordStrength(pass);
      Color passwordStrengthBarColor = Colors.red;
      if (passwordStrength < 0.4) {
        passwordStrengthBarColor = Colors.red;
      } else if (passwordStrength > 0.4 && passwordStrength < 0.7) {
        passwordStrengthBarColor = Colors.deepOrangeAccent;
      } else if (passwordStrength < 0.7) {
        passwordStrengthBarColor = Colors.orange;
      } else if (passwordStrength > 0.7 || passwordStrength == 0.7) {
        passwordStrengthBarColor = Colors.green;
      }
      setState(() {
        this.passwordStrengthBarColor = passwordStrengthBarColor;
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Container(
                  height: 80,
                  color: Theme
                      .of(context)
                      .canvasColor
                      .withOpacity(0.3),
                  child: SafeArea(
                    child: Row(
                        children: <Widget>[
                    IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: handleBack,
                  ),
                 Text(
                  "Add Social Details",
                  style: TextStyle(
                      fontFamily: "Title", fontSize: 26, color: primaryColor),
                ),
                  IconButton(
                    icon: Icon(Icons.cancel_sharp),
                    onPressed: () {
                      handleDelete();
                    },
                  ),
                  ],
              ),
            ),
      )),

    ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        focusNode: appNameFocus,
                      cursorColor: Colors.purple,
                        autofocus: true,
                        onChanged: (value) {
                          markappNameAsDirty(value);
                      /*validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid title';
                        }*/
                      },

                      decoration: InputDecoration(
                          labelText: " Social Title",
                          labelStyle: TextStyle(fontFamily: "Subtitle"),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(16))),
                      controller: appNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      cursorColor: Colors.purple,
                      onChanged: (value) {
                        markuserNameAsDirty(value);
                      /*validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter valid Username';
                        }*/
                      },
                      decoration: InputDecoration(
                          labelText: "Social Media UserName",
                          labelStyle: TextStyle(fontFamily: "Subtitle"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16))),
                      controller: userNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: Colors.purple,
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Please enter valid password';
                      //   }
                      // },
                      onChanged: (pass) {
                        //checkPassStrength(pass);
                      },
                      obscureText: obscureText,
                      decoration: InputDecoration(
                        // errorText: 'Please enter valid password',
                        labelText: "Social Media Password",
                        labelStyle: TextStyle(fontFamily: "Subtitle"),
                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      controller: passwordController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                       /* FlatButton(
                          onPressed: () {
                            String pass = randomAlphaNumeric(10);
                            passwordController.text = pass;
                            checkPassStrength(pass);
                          },
                          child: Text('Generate'),
                        ),*/
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                              if (obscureText) {
                                show_hide = 'Show Password';
                              } else {
                                show_hide = 'Hide Password';
                              }
                            });
                          },
                          child: Text(show_hide),
                        ),
                        FlatButton(
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(
                                text: passwordController.text));
                            scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                content: Text("Copied to Clipboard"),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text('Copy'),
                        ),
                      ],
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: 10,
                        width: passwordStrength == 0
                            ? 5
                            : MediaQuery.of(context).size.width *
                                passwordStrength,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: passwordStrengthBarColor,
                        ),
                      ),
                    ),
                  ),*/
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Text(
                            "Pick an Icon",
                            style: TextStyle(
                                fontFamily: 'Title',
                                fontSize: 20,
                                color: primaryColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8.0, top: 8.0),
                          child: Material(
                            shape: CircleBorder(),
                            elevation: 4.0,
                            child: CircleAvatar(
                                backgroundColor: pickedColor,
                                radius: 25,
                                child: icons[pickedIcon]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0, 24, 10),
                    child: GridView.count(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 5,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 15,
                        childAspectRatio: 1.3,
                        children: List.generate(icons.length, (index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                pickedIcon = index;
                              });
                            },
                            child: Material(
                                elevation: 4.0,
                                color: pickedColor,
                                shape: CircleBorder(),
                                child: icons[index]),
                          );
                        })),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Pick a Color",
                            style: TextStyle(
                                fontFamily: 'Title',
                                fontSize: 20,
                                color: primaryColor),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _openColorPicker();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 8.0),
                            child: Material(
                                shape: CircleBorder(),
                                elevation: 4.0,
                                child: CircleAvatar(
                                  backgroundColor: pickedColor,
                                  radius: 25,
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            encryptPass(passwordController.text);
            Social social = new Social(
                appName: appNameController.text,
                password: encryptedString,
                color: "#" + pickedColor.value.toRadixString(16),
                icon: iconNames[pickedIcon],
                userName: userNameController.text);
            DBProvider.db.newSocial(social);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Home()),
                (Route<dynamic> route) => false);
          }
          else {
             print(Theme.of(context).accentColor);
          }
          if (isNoteNew) {
          var latestNote = DBProvider.db.addNote1InDB(currentNote);
            setState(() {
                currentNote = latestNote;
               });
            }
            else {
             DBProvider.db.getAllSocial();
          // print(Theme.of(context).accentColor);
          }
        setState(() {
          isNoteNew = false;
          isDirty = false;
        });
        widget.triggerRefetch();
        appNameFocus.unfocus();
        userNameFocus.unfocus();
        passwordFocus.unfocus();
      }


  ),
    );
  }

  _openColorPicker() async {
    Color _tempShadeColor = pickedColor;
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text("Color picker"),
          actions: [
            FlatButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            FlatButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  pickedColor = _tempShadeColor;
                });
              },
            ),
          ],
          content: MaterialColorPicker(
            allowShades: true,
            selectedColor: _tempShadeColor,
            onColorChange: (color) => setState(() => _tempShadeColor = color),
            onMainColorChange: (color) =>
                setState(() => _tempShadeColor = color),
          ),
        );
      },
    );
  }

  encryptPass(String text) {
    keyString = masterPassString;
    if (keyString.length < 32) {
      int count = 32 - keyString.length;
      for (var i = 0; i < count; i++) {
        keyString += ".";
      }
    }
    final key = encrypt.Key.fromUtf8(keyString);
    final plainText = text;
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final e = encrypter.encrypt(plainText, iv: iv);
    encryptedString = e.base64.toString();
  }
  void markappNameAsDirty(String title) {
    setState(() {
      isDirty = true;
    });
  }

  void markuserNameAsDirty(String content) {
    setState(() {
      isDirty = true;
    });
  }

  void handleDelete() async {
    if (isNoteNew) {
      Navigator.pop(context);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text('Delete Note'),
              content: Text('This note will be deleted permanently'),
              actions: <Widget>[
                FlatButton(
                  child: Text('DELETE',
                      style: TextStyle(
                          color: Colors.red.shade300,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
                  onPressed: () async {
                    await DBProvider.db.deleteAll();
                    var widget;
                    widget.triggerRefetch();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('CANCEL',
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
    }
  }

  void handleBack() {
    Navigator.pop(context);
  }
}

