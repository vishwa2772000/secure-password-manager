import 'package:personal/CARDS/pages/PasswordHomepage.dart';
import 'package:personal/PROFILE/EditProfile.dart';
import 'package:personal/SETTINGS/SettingsPage.dart';

import 'package:personal/SOCIAL/pages/SocialHomepage.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState()  => _HomeState();
// TODO: implement createState

}

class _HomeState extends State<Home>{
  int currentTab = 0;
  final List<Widget> Screen =[
    SocialHomepage(),
    SettingsPage(),
    EditProfile(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen =   PasswordHomepage();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: PageStorage(
        child: currentScreen ,
        bucket :bucket,

      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat*/
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child :Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:<Widget> [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed:(){
                        setState(() {
                          currentScreen =  PasswordHomepage();
                          currentTab = 0;

                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.credit_card_outlined,
                            color: currentTab == 0 ? Colors.deepPurple :Colors.grey,
                          ),
                          Text(
                            'CARD',
                            style: TextStyle(
                                color: currentTab == 0 ?  Colors.deepPurple :Colors.grey
                            ) ,
                          )

                        ],
                      ) ,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed:(){
                            setState(() {
                              currentScreen = SocialHomepage();
                              currentTab = 1;

                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.blur_circular_rounded,
                                color: currentTab == 1 ? Colors.deepPurple :Colors.grey,
                              ),
                              Text(
                                'Social Media',
                                style: TextStyle(
                                    color: currentTab == 1 ?  Colors.deepPurple :Colors.grey
                                ) ,
                              )

                            ],
                          ) ,
                        )
                      ],
                    ),
                    //edit profile

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //setting
                        MaterialButton(
                          minWidth: 40,
                          onPressed:(){
                            setState(() {
                              currentScreen = SettingsPage();
                              currentTab = 2;

                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings,
                                color: currentTab == 2 ? Colors.deepPurple :Colors.grey,
                              ),
                              Text(
                                'Settings',
                                style: TextStyle(
                                    color: currentTab == 2 ?  Colors.deepPurple :Colors.grey
                                ) ,
                              )

                            ],
                          ) ,
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MaterialButton(
                          minWidth: 40,
                          onPressed:(){
                            setState(() {
                              currentScreen = EditProfile();
                              currentTab = 3;

                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.supervisor_account,
                                color: currentTab == 3 ? Colors.deepPurple :Colors.grey,
                              ),
                              Text(
                                'Credits',
                                style: TextStyle(
                                    color: currentTab == 3 ?  Colors.deepPurple :Colors.grey
                                ) ,
                              )

                            ],
                          ) ,
                        ),
                      ],
                    ),

                  ],
                )
              ]
          ),
        ),
      ),
    );
  }


}
