import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'WeighLog.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  myApp createState() => myApp();
}

class myApp extends State<MyApp> {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeightEntries(),
      theme: ThemeData(fontFamily: "Oswald"),
    );
  }
}




class Test extends StatefulWidget {
  _test createState() => _test();
}

class _test extends State<Test> {
  int _currentValue = 1;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new NumberPicker.integer(
                initialValue: _currentValue,
                minValue: 0,
                maxValue: 100,
                onChanged: (newValue) =>
                    setState(() => _currentValue = newValue)),
            new Text("Current number: $_currentValue"),
          ],
        ),
      ),
    );
  }
}



