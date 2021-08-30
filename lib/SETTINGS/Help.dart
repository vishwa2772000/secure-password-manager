import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

//import '../colors.dart';
//import '../constaints.dart';
class Help extends StatefulWidget {
  Help({Key key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Help> {
  _makingPhoneCall() async{
    const url='tel:6351071346';
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw 'Not Able To Connect';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6F35A5),
        title: Text("Help"),
      ),
      body: Center(
        child:Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
          child: Column(
            //even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[

                  Image(
                  color: Colors.deepPurple,
                  height: 250,
                  width: 300,
                  image: AssetImage("assets/ic_wa.png"),
                  ),
                  Column(
                    children: <Widget>[
                      //login button
                      Text("Version 1.0", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),),
                      SizedBox(height: 20,),

                      MaterialButton(
                        minWidth: double.maxFinite,
                        height: 60,
                        onPressed:(){
                          //Navigator.push(context, MaterialPageRoute(builder:(context)=>()));
                          _makingPhoneCall();
                        },
                        //defining the shape
                        color: Color(0xFF6F35A5),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xFF6F35A5)
                            ),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text(
                          "Contact Us",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18

                          ),
                        ),
                      ),
                      //creating Sigup button

                    ],
                  ),
                ],
              )
            ],
          ),
      ),




      )
    );
  }


}