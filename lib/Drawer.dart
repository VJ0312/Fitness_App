import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:weighttracker/BFCalculator.dart';
import 'WeighLog.dart';
import 'BMICalculator.dart';
import 'Graph.dart';
import 'CaloricNeeds.dart';

class DrawerWidget extends StatefulWidget {
  _DrawerWidget createState() => _DrawerWidget();
}

class _DrawerWidget extends State<DrawerWidget> {
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
    color: Colors.blue,
    ),
          child: Center(
            child: Text(
              "Weight Tracker", style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
            ),
          ),
        ),
        SizedBox(
          height: 35,
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeightEntries()),
              );
            });
          },
          child: Text("Weight Log",
              style: TextStyle(
                fontSize: 30,
              )),
        ),
        SizedBox(
          height: 35,
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Graph()),
              );
            });
          },
          child:  Text("Monthly Graph",
              style: TextStyle(
                fontSize: 30,
              )),
        ),
        SizedBox(
          height: 35,
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BMICalculator()),
              );
            });
          },
          child: Text("BMI Calculator",
              style: TextStyle(
                fontSize: 30,
              )),
        ),
        SizedBox(
          height: 35,
        ),
        FlatButton(
          child: Text(
            "Body Fat Percentage Calculator",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BFCalculator()
            ));
          }
        ),
        SizedBox(
          height: 35,
        ),
        FlatButton(
            child: Text(
              "Caloric Needs",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => (CaloricNeeds())
              ));
            }
        ),
      ],
    );
  }
}