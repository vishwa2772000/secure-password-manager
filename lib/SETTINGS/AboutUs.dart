import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal/SETTINGS//read_more_text.dart';

class AboutUs extends StatefulWidget{
  @override
  _AboutUsState createState() =>_AboutUsState();

}

class _AboutUsState extends State<AboutUs>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF6F35A5),
          title: Text("Abot Us"),
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
                        Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        padding: EdgeInsets.all(10.0),
                        child: Text("Version 1.0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),),
                        ),

                        SizedBox(height: 20,),
                        Divider(color: Colors.grey),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ReadMoreText(
                            'This application will store different type of passwords with encrypted format which no one can read directly from application if you also want to read you need to enter one pass code after you will be able to read the pin numbers and documents.',
                            trimLines: 2,
                            colorClickableText: Colors.pink,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '...Read more',
                            trimExpandedText: ' Less',
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


