
import 'package:personal/SETTINGS//data/rate_operation.dart';
import 'package:personal/SETTINGS/models/RateModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

class RateApp extends StatefulWidget {
  RateApp({Key key}) : super(key: key);



  @override
  _RateAppPage createState() => _RateAppPage();
}
class _RateAppPage extends State<RateApp> {
  RateOperations rateOperations =RateOperations();
  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // appStoreIdentifier: '',
    // googlePlayIdentifier: '',
  );

  @override
  void initState() {
    super.initState();
    _rateMyApp.init().then((_) {

          _rateMyApp.showStarRateDialog(
              context,
              title: "Satisfied With The App?",
              message: "Please leave a rating!",
              actionsBuilder: (context,stars) {
                return [
                  FlatButton(
                    child: Text('Ok'),
                    onPressed: (){
                      if(stars !=null) {
                        /*
                      //  _rateMyApp.doNotOpenAgain = true;
                        _rateMyApp.save().then((value) =>
                            Navigator.pop(context));
                        if (stars <= 3) {
                             print('Navigate to Contact Us Screen');
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => ContactUsScreen(),
                          //   ),
                          // );
                        }
                        else if(stars <= 5) {
                            print('Leave a Review Dialog');
                            // showDialog(...);

                       }*/
                        final rateapp=RateModel(
                            rate: stars.toString(),

                        );
                        rateOperations.addrate(rateapp);
                        Navigator.pop(context);

                      }
                      else
                        {
                          Navigator.pop(context);

                    }
                    },
                  )

                ];
              },
              dialogStyle: DialogStyle(
                titleAlign: TextAlign.center,
                messageAlign: TextAlign.center,
                messagePadding: EdgeInsets.only(bottom: 20.0),
              ),
            starRatingOptions: StarRatingOptions(),

          );
       // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rate App"),
        backgroundColor:  Color(0xFF6F35A5),
      ),
    );
  }
}