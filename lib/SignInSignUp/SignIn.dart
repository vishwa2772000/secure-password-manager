import 'package:flutter/material.dart';
import 'package:personal/SignInSignUp/SignUP.dart';
import 'package:personal/home.dart';
import 'package:personal/main.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:personal/SignInSignUp/models/User.dart';
import 'package:personal/SignInSignUp/data/database_Helper.dart';
import 'package:personal/CARDS/pages/SetMasterPassword.dart';


class LoginUserPage extends StatefulWidget {


  @override
  SignIn createState() => SignIn();

  Brightness brigntness = Brightness.light;

  LoginUserPage({this.brigntness});
}
class SignIn extends State<LoginUserPage> {

  final usernameController=TextEditingController();
  final passwordController=TextEditingController();
  //String email_pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String password_pattern = r'^[0-9]{4}$';




  final  _formkey=GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();



  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    // print(iconNames.indexOf('Icon 10'));

    void changeBrightness() {
      DynamicTheme.of(context).setBrightness(
          Theme.of(context).brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark);
    }
    return Scaffold(
      key: _scafoldKey,
      resizeToAvoidBottomInset: false,

      body:Form(
        key: _formkey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("Sign In",
                        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      SizedBox(height: 20,),

                    /*  Text("Sign In to your account",
                        style: TextStyle(
                            fontSize: 15,
                            color:Colors.grey[700]),)
                    */],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child:Column(
                      children: [
                        //pin
                        TextFormField(
                          cursorColor: Color(0xFF6F35A5),
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          validator: (value){
                            if(value.isEmpty)
                            {
                              return "Field Should Not Be Empty";
                            }
                            else {
                              return null;
                            }
                          },
                          onSaved: (String email){

                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Enter 4 Digit Pin Code",
                              labelText: "Enter 4 Digit Pin Code",
                              contentPadding: EdgeInsets.symmetric(vertical: 0,
                                  horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[400]
                                ),

                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey[400])
                              )
                          ),
                        ),
                      ],
                    ),

                  ),
                  Padding(padding:
                  EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.only(top: 2, left: 2),
                      decoration:
                      BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),

                          )



                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          if(_formkey.currentState.validate())
                          {
                            DatabaseHelper.instance.checkUserLogin(passwordController.text).then((result){


                              if(result==null)
                              {

                                _scafoldKey.currentState.showSnackBar(SnackBar(content: Text("Please enter valid details")));
                              }
                              else
                              {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                              }
                            });
                          }

                        },
                        color: Color(0xFF6F35A5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),

                        ),
                        child: Text(

                          "Sign In", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white,


                        ),


                        ),

                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?"),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>AddUserPage()));
                        },
                        child: Text(" Register", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,

                        ),),
                      )


                    ],
                  ),

                  Container(

                    padding: EdgeInsets.only(top: 100),
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/login.png"),
                          fit: BoxFit.fitHeight
                      ),
                    ),
                  )

                ],
              ))
            ],
          ),
        ),
      )
    );
  }
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 9), radix: 16) + 0xFF000000);
  }



}


