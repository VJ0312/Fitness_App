import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'Drawer.dart';
import 'package:mdi/mdi.dart';

class BMICalculator extends StatefulWidget {
  @override
  bmicalculator createState() => bmicalculator();
}

class bmicalculator extends State<BMICalculator> {
  int age = 20, weight = 150, _height = 60;
  double heightVal = 60.0, BMI, bmi;
  var category;
  bool male = false, calculated = false;
  Widget BMICalculatorPage() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                  color: male? Colors.grey : Colors.white,
                  child: Column(
                    children: [
                      Text("Male"),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(Mdi.genderMale, color: Colors.lightBlueAccent),
                        iconSize: 100,
                        onPressed: () {
                          setState(() {
                            male = true;
                          });
                        },
                      ),
                    ],
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 3.5,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                  color: male? Colors.white : Colors.grey,
                  child: Column(
                    children: [
                      Text("Female"),
                      SizedBox(height: 10),
                      IconButton(
                        icon: Icon(Mdi.genderFemale, color: Colors.pinkAccent[200]),
                        iconSize: 100,
                        onPressed: () {
                          setState(() {
                            male = false;
                          });
                        },
                      ),
                    ],
                  )),
            ),
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          child: Card(
              child: Column(
                children: [
                  Text("Height"),
                  SizedBox(height: 10),
                  Text(
                    "$_height in",
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  ),
                  Slider(
                    value: heightVal,
                    min: 40,
                    max: 100,
                    label: heightVal.round.toString(),
                    onChanged: (double value) {
                      setState(() {
                        heightVal = value;
                        _height = heightVal.toInt();
                      });
                    },
                  )
                ],
              )),
        ),
        Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                  child: Column(
                    children: [
                      Text("Weight"),
                      SizedBox(height: 10),
                      Text("$weight lb",
                          style: TextStyle(
                            fontSize: 30,
                          )),
                      Padding(
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(MaterialIcons.remove),
                                iconSize: 50,
                                onPressed: () {
                                  if (weight >= 50) {
                                    setState(() {
                                      weight--;
                                    });
                                  }
                                }),
                            IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 50,
                                onPressed: () {
                                  if (weight <= 600)
                                    setState(() {
                                      weight++;
                                    });
                                })
                          ],
                        ),
                        padding: EdgeInsets.only(left: 30),
                      ),
                    ],
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width / 2,
              child: Card(
                  child: Column(
                    children: [
                      Text("Age"),
                      SizedBox(height: 10),
                      Text("$age",
                          style: TextStyle(
                            fontSize: 30,
                          )),
                      Padding(
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(MaterialIcons.remove),
                                iconSize: 50,
                                onPressed: () {
                                  if (age > 9) {
                                    setState(() {
                                      age--;
                                    });
                                  }
                                }),
                            IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 50,
                                onPressed: () {
                                  if (age < 100) {
                                    setState(() {
                                      age++;
                                    });
                                  }
                                })
                          ],
                        ),
                        padding: EdgeInsets.only(left: 30),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        Container(
          color: Colors.blue,
          height: 66,
          width: MediaQuery.of(context).size.width,
          child: Card(
              color: Colors.blue,
              child: Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      calculate(male, age, weight, heightVal);
                    },
                    child: Text(
                      "Calculate",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ))),
        ),
      ],
    );
  }

  Widget BMICalulatedPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
           child: Column(
              children: [
                Text(
                    "Your BMI is: ", style: TextStyle(
                  fontSize: 40,
                )
                ),
                Text("$bmi", style: TextStyle(
                  fontSize: 40,
                )),
                Text(
                    "Your weight is in the $category category",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                  fontSize: 40,
                )
                ),
              ],
            ),
        )
      ],
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("BMI Calculator"),
      ),
      body: !calculated?  BMICalculatorPage() : BMICalulatedPage(),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
    );
  }

  void calculate(bool gender, int age, int weight, double height) {
    setState(() {
      BMI = (703 * weight) / (height * height);
      bmi = double.parse((BMI).toStringAsFixed(2));
      calculated = true;
      if (BMI < 18.5) {
        category = "underweight";
      }
      else if (BMI >= 18.5 && BMI < 24.9) {
        category = "normal";
      }
      else if (BMI < 29.9 && BMI <= 24.9) {
        category = "overweight";
      }
      else {
        category = "obese";
      }
    });
  }
}
