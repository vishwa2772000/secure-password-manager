import 'dart:async';
import 'package:personal/SETTINGS/SettingsPage.dart';
import 'package:personal/SOCIAL/bloc/SocialBloc.dart';
import 'package:personal/SOCIAL/database/Database.dart';
import 'package:personal/SOCIAL/model/SocialModel.dart';
import 'package:personal/SOCIAL/pages/ViewSocialPage.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:personal/faderoute.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:flutter/cupertino.dart';
import 'AddSocialPage.dart';

class SocialHomepage extends StatefulWidget {
  @override
  _SocialHomepageState createState() => _SocialHomepageState();

  Brightness brigntness = Brightness.light;

  SocialHomepage({this.brigntness});
}

class _SocialHomepageState extends State<SocialHomepage> {
  int pickedIcon;
  bool headerShouldHide = false;
  List<Social> notesList = [];
  TextEditingController searchController = TextEditingController();

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

  final bloc = SocialBloc();
  @override
  void initState() {
    super.initState();
    DBProvider.db.initDB();
    setNotesFromDB();
  }
  setNotesFromDB() async {
    print("Entered setNotes");
    var fetchedNotes = await DBProvider.db.getAllSocial();
    setState(() {
      notesList = fetchedNotes;
    });
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
    DBProvider.db.initDB();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color primaryColor = Theme.of(context).primaryColor;

    // print(iconNames.indexOf('Icon 10'));

    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Social Details",
                      style: TextStyle(
                          fontFamily: "Title",
                          fontSize: 32,
                          color: Colors.deepPurple
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.wb_sunny,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () {
                            changeBrightness();
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SettingsPage()));
                          },
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Expanded(
            child: StreamBuilder<List<Social>>(
              stream: bloc.social,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.length > 0) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        Social social = snapshot.data[index];
                        int i = 0;
                        i = iconNames.indexOf(social.icon);
                        Color color = hexToColor(social.color);
                        return Dismissible(
                          key: ObjectKey(social.id),
                          onDismissed: (direction) {
                            var item = social;
                            //To delete
                            DBProvider.db.deleteSocial(item.id);
                            setState(() {
                              snapshot.data.removeAt(index);
                            });
                            //To show a snackbar with the UNDO button
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Password deleted"),
                                action: SnackBarAction(
                                    label: "UNDO",
                                    onPressed: () {
                                      DBProvider.db.newSocial(item);
                                      setState(() {
                                        snapshot.data.insert(index, item);
                                      });
                                    })));
                          },
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ViewSocial(
                                            social: social,
                                          )));
                            },
                            child: ListTile(
                              title: Text(
                                social.appName,
                                style: TextStyle(
                                  fontFamily: 'Title',
                                ),
                              ),
                              leading: Container(
                                  height: 48,
                                  width: 48,
                                  child: CircleAvatar(
                                      backgroundColor: color, child: icons[i])),
                              subtitle: social.userName != ""
                                  ? Text(
                                      social.userName,
                                      style: TextStyle(
                                        fontFamily: 'Subtitle',
                                      ),
                                    )
                                  : Text(
                                      "No username specified",
                                      style: TextStyle(
                                        fontFamily: 'Subtitle',
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "No Passwords Saved. \nClick \"+\" button to add a social password",
                        textAlign: TextAlign.center,
                        // style: TextStyle(color: Colors.black54),
                      ),
                    );
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddSocial()));
        },
      ),
    );
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }
  void gotoEditNote() {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                AddSocial(triggerRefetch: refetchNotesFromDB)));
  }

  void refetchNotesFromDB() async {
    await setNotesFromDB();
    print("Refetched notes");
  }

  openNoteToRead(Social noteData) async {
    setState(() {
      headerShouldHide = true;
    });
    await Future.delayed(Duration(milliseconds: 230), () {});
    Navigator.push(
        context,
        FadeRoute(
            page: ViewSocial(
                triggerRefetch: refetchNotesFromDB, currentNote: noteData)));
    await Future.delayed(Duration(milliseconds: 300), () {});

    setState(() {
      headerShouldHide = false;
    });
  }



  Widget notesHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 2.5,
        right: 2.5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cards",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.00,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}



