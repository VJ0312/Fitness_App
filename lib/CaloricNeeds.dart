import 'package:flutter/material.dart';
import 'package:weighttracker/BFCalculator.dart';
import 'package:weighttracker/Drawer.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class CaloricNeeds extends StatefulWidget {
  _CaloricNeeds createState() => _CaloricNeeds();
}

enum Genders {male, female}
Genders genders = Genders.male;

enum WUnits {pounds, kilos}
WUnits wUnits = WUnits.pounds;

enum HUnits {inches, cm}
HUnits hUnits = HUnits.inches;


class _CaloricNeeds extends State<CaloricNeeds> {
  final ageController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  String excerciseLevel = 'Moderate: exercise 3-4 times per week';
  String weightGoal = 'Maintenance';

  int age, weight, height;
  double calories;

  bool calculated = false;

  void initState() {
    super.initState();
    calculated = false;
  }

  Widget calculatedCaloriesScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
           child: Container(
             child :Text(
                 "You need to consume ${calories.toInt()} calories",
               textAlign: TextAlign.center,
               style: TextStyle(
               fontSize: 60
             ),
             )
            )
        )
      ],
    );
  }

  Widget textBox(TextEditingController _controller, var _width, var _height) {
    return Container(
      width: _width,
      height: _height,
      child: TextField(
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 25,
        ),
        controller: _controller,
        onChanged: (value) {
          setState(() {
            if (_controller == ageController) {
              age = int.parse(_controller.text.toString());
            }
            else if (_controller == weightController) {
              wUnits == WUnits.pounds? weight = int.parse(_controller.text.toString())
              : weight = 2 * int.parse(_controller.text.toString());
            }
            else {
            height = int.parse(_controller.text.toString());
              print(height);
            }
          });
        },
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    void calculateC(var _age, _gender, _weight, _height, _exercise, _goal) {
      calculated =  true;

      double atRest = _gender == Genders.male? (10*_weight) + (6.25* _height) - (5 *_age) + 5
          :10*_weight + 6.25 * _height - 5*_age - 161;

      double caloriesNeeded;

      switch (_goal) {
        case "Extreme weight loss (1kg/week)" :
          caloriesNeeded = atRest - 1000;
          break;
        case "Weight loss (0.5kg/week)" :
          caloriesNeeded = atRest - 500;
          break;
        case "Maintenance" :
          caloriesNeeded = atRest;
          break;
        case "Weight Gain: (0.5kg/week)" :
          caloriesNeeded = atRest + 500;
          break;
        default:
          break;
      }

      switch (_exercise) {
        case "Little or no exercise" :
          caloriesNeeded = caloriesNeeded + 100;
          break;
        case "Light: exercise 1-2 times per week" :
          caloriesNeeded += 150;
          break;
        case "Moderate: exercise 3-4 times per week" :
          caloriesNeeded += 200;
          break;
        case "Active: exercise 5 times per week" :
          caloriesNeeded += 400;
          break;
        case "Very Active: intense exercise 6-7 times per week":
          caloriesNeeded += 600;
          break;
        case 'Extremely Active: very intense daily exercise':
          caloriesNeeded += 800;
          break;
        default:
          break;
      }
      calories = caloriesNeeded;
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
            appBar: AppBar(
                title: Center(
                    child:
                    Row(
                      children: [
                        SizedBox(width: 80),
                        Text(
                            "Caloric Needs"
                        ),
                      ],
                    )
                )
            ),
            drawer: Drawer(
              child: DrawerWidget(),
            ),
            body: calculated? calculatedCaloriesScreen() : Card(
              child:
              Column(
                children: [
                  Text(
                    "Caloric Needs Calculator", style: TextStyle(
                    fontSize: 40,
                  )
                  ),
                  SizedBox(height: 10),
                  Container(
                      height: MediaQuery.of(context).size.height/1.3,
                      width: MediaQuery.of(context).size.width,
                      child:ListView(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text("Age",
                                      style: TextStyle(
                                    fontSize: 25,
                                  )),
                                ),
                                SizedBox(width: 20),
                                textBox(ageController, 100.0, 50.0)
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Gender", style: TextStyle(
                                fontSize: 25
                              )
                              ),
                                  Row(
                                    children: [
                                      Radio(
                                        groupValue: genders,
                                        value: Genders.male,
                                        onChanged: (Genders value) {
                                          setState(() {
                                            genders = value;
                                          });
                                        },
                                      ),
                                      Text(
                                        "Male"
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Radio(
                                        groupValue: genders,
                                        value: Genders.female,
                                        onChanged: (Genders value) {
                                          setState(() {
                                            genders = value;
                                          });
                                        },
                                      ),
                                      Text(
                                          "Female"
                                      )
                                    ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Weight", style: TextStyle(
                                fontSize: 25,
                              )
                              ),
                              SizedBox(width: 10),
                              textBox(weightController, 120.0, 60.0),
                              Radio(
                                value: WUnits.pounds,
                                groupValue: wUnits,
                                onChanged: (WUnits value) {
                                  setState(() {
                                    wUnits = value;
                                  });
                                },
                              ),
                              Text(
                                "Pounds"
                              ),
                              Radio(
                                value: WUnits.kilos,
                                groupValue: wUnits,
                                onChanged: (WUnits value) {
                                  setState(() {
                                    wUnits = value;
                                  });
                                },
                              ),
                              Text(
                                  "Kilos"
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Height", style: TextStyle(
                                fontSize: 25,
                              )
                              ),
                              SizedBox(width: 10),
                              textBox(heightController, 120.0, 60.0),
                              Radio(
                                value: HUnits.inches,
                                groupValue: hUnits,
                                onChanged: (HUnits value) {
                                  setState(() {
                                    hUnits = value;
                                  });
                                },
                              ),
                              Text(
                                  "Inches"
                              ),
                              Radio(
                                value: HUnits.cm,
                                groupValue: hUnits,
                                onChanged: (HUnits value) {
                                  setState(() {
                                    hUnits = value;
                                  });
                                },
                              ),
                              Text(
                                  "Cm"
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10
                          ),
                          Container(
                              child: DropDownFormField(
                                value: excerciseLevel,
                                titleText: "Exercise level",
                                onSaved: (value) {
                                  setState(() {
                                    excerciseLevel = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    excerciseLevel = value;
                                  });
                                },
                                dataSource: [
                                  {
                                    'display' : 'Little or no exercise',
                                    'value' : 'Little or no exercise',
                                  },
                                  {
                                    'display' : 'Light: exercise 1-2 times per week',
                                    'value' : 'Light: exercise 1-2 times per week',
                                  },
                                  {
                                    'display' : 'Moderate: exercise 3-4 times per week',
                                    'value' : 'Moderate: exercise 3-4 times per week',
                                  },
                                  {
                                    'display' : 'Active: exercise 5 times per week',
                                    'value' : 'Active: exercise 5 times per week',
                                  },
                                  {
                                    'display' : 'Very Active: intense exercise 6-7 times per week',
                                    'value' : 'Very Active: intense exercise 6-7 times per week',
                                  },
                                  {
                                    'display' : 'Extremely Active: very intense daily exercise',
                                    'value' : 'Extremely Active: very intense daily exercise',
                                  },
                                ],
                                textField: 'display',
                                valueField: 'value',
                              )
                          ),
                          Container(
                              child: DropDownFormField(
                                value: weightGoal,
                                titleText: "Goal",
                                onSaved: (value) {
                                  setState(() {
                                    weightGoal = value;
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    weightGoal = value;
                                  });
                                },
                                dataSource: [
                                  {
                                    'display' : 'Extreme weight loss (1kg/week)',
                                    'value' : 'Extreme weight loss (1kg/week)',
                                  },
                                  {
                                    'display' : 'Weight loss (0.5kg/week)',
                                    'value' : 'Weight loss (0.5kg/week)',
                                  },
                                  {
                                    'display' : 'Maintenance',
                                    'value' : 'Maintenance',
                                  },
                                  {
                                    'display' : 'Weight Gain: (0.5kg/week)',
                                    'value' : 'Weight Gain: (0.5kg/week)',
                                  },
                                ],
                                textField: 'display',
                                valueField: 'value',
                              )
                          ),
                          SizedBox(
                            height: 10,
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
                                        setState(() {
                                          // calculate(age, genders, weight, height, excerciseLevel, weightGoal);
                                          calculateC(age, genders, weight, height, excerciseLevel, weightGoal);
                                           print(calories);
                                        });
                                      },
                                      child: Text(
                                        "Calculate",
                                        style: TextStyle(fontSize: 30, color: Colors.white),
                                      ),
                                    ))),
                          ),
                        ],
                      )
                  ),
                ],
              ),
            )
    );
  }
}
