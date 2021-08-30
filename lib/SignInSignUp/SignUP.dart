
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal/SignInSignUp/SignIn.dart';
import 'package:personal/SignInSignUp/models/User.dart';
import 'package:personal/SignInSignUp/data/database_Helper.dart';


/*GoogleSignIn _googleSignIn=GoogleSignIn(
    scopes: [
      'profile',
      'email'
    ]
);*/
class AddUserPage extends StatefulWidget {


  @override
  SignUp createState() => SignUp();
  Brightness brigntness = Brightness.light;

  AddUserPage({this.brigntness});
}

class SignUp extends State<AddUserPage> {
  @override
 /* void initState() {
    // TODO: implement initState
    super.initState();


    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount accout){
      setState(() {
        _currentuser=accout;
      });
    });
    _googleSignIn.signInSilently();
  }*/
 // GoogleSignInAccount _currentuser;
  //var isLoggedin=false;
  final  _formkey=GlobalKey<FormState>();
  final _scafoldKey = GlobalKey<ScaffoldState>();
  final _nameController=TextEditingController();
  final _emailContoller=TextEditingController();
  final _passwordController=TextEditingController();
  final _cpasswordController=TextEditingController();
  final _profileContoller="nill";
  String email_pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  String password_pattern = r'^[a-zA-Z0-9]{6,}$';




  @override
  Widget build(BuildContext context) {
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
                        Text("Register Your Details",
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Text("Create an account, It's free",
                          style: TextStyle(
                              fontSize: 15,
                              color:Colors.grey[700]),)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child:Column(
                        children: [

                          //email
                          TextFormField(
                            controller: _emailContoller,
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Color(0xFF6F35A5),
                            validator: (String value)
                            {
                              RegExp regex =RegExp(email_pattern);
                              if(value.isEmpty)
                              {
                                return "Field Should Not Be Empty";
                              }
                              else if(!regex.hasMatch(value))
                                {
                                  return 'Enter Valid Email';
                                }

                              return null;
                            },
                            onSaved: (String email){

                            },
                            decoration: InputDecoration(
                                hintText: "Enter Email",
                                labelText: "Enter Email",
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
                          SizedBox(height: 30,),
                          //pass
                          TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _passwordController,
                            cursorColor: Color(0xFF6F35A5),
                            validator: (String value){

                              if(value.isEmpty)
                              {
                                return "Field Should Not Be Empty";
                              }
                              return null;
                            },
                            onSaved: (String email){

                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Create 4 Digit Pin Code",
                                labelText: "Create 4 Digit Pin Code",
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
                              DatabaseHelper.instance.insert(User(_emailContoller.text,_passwordController.text)).then((result) {
                                if(result!=-1)
                                  {
                                    print(result);
                                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginUserPage()));
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
                            "Register", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,

                          ),
                          ),

                        ),
                      ),
                    ),
/*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already Registered?"),

                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>LoginUserPage()));
                          },
                          child: Text(" Sign In", style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,

                          ),),
                        )
                      ],
                    ),
*/
              /*      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Color(0xFFF1E6FF),
                            ),
                            shape: BoxShape.circle,

                          ),
                          child:GestureDetector(
                            onTap: (){
                              if(_currentuser!=null)
                              {

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SetMasterPassword()));
                              }
                              else
                              {
                                _handleSignIn();
                                if(isLoggedin ==true)
                                {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SetMasterPassword()));
                                }


                              }
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/images/google-plus.png"),
                                ),

                              ),
                            )
                            ,

                          ),
                        ),
                      ],
                    ),*/
                    Container(
                      padding: EdgeInsets.only(top: 100),
                      height: 250,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/signup.png"),
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
/*
  Future<void> _handleSignIn() async{
    try{
      await _googleSignIn.signIn();
      isLoggedin=true;

    }catch(error){
      print(error);
    }
  }
*/
}


