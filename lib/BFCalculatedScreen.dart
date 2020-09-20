import 'package:flutter/material.dart';
import 'BFCalculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BFCalcScreen extends StatefulWidget {
  bfCalcScreen createState() => bfCalcScreen();
}

class bfCalcScreen extends State <BFCalcScreen>{
  double bodyFat;
  String category;

  Future<void> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bodyFat = double.parse(prefs.getDouble("bf").toStringAsFixed(2));
      category = prefs.getString("category");
    });
  }

  void initState() {
    super.initState();
    getPrefs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Body Fat Calculator"
          )
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Your body fat percentage is: ",
                style: TextStyle(
                  fontSize: 40,
                )),
            Text("$bodyFat%",
                style: TextStyle(
                  fontSize: 40,
                )),
            Text("Your weight is in the $category category",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                )),
          ],
        )
      );
  }
}