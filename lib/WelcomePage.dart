import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal/SignInSignUp/SignIn.dart';
import 'package:personal/SignInSignUp/SignUP.dart';
class WelcomePage extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
          child: Column(
            //even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("WELCOME TO PERSONAL SECURE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height/1.8,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/chat1.png")
                        )
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      //login button
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginUserPage()));
                        },
                        //defining the shape
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),
                        ),
                      ),
                      //creating Sigup button
                      SizedBox(height: 20),
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed:(){
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>AddUserPage()));
                        },
                        color: Color(0xFF6F35A5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)

                        ),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}