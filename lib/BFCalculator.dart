import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'Drawer.dart';
import 'package:mdi/mdi.dart';
import 'package:math_expressions/math_expressions.dart';
import 'BFCalculatedScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BFCalculator extends StatefulWidget {
  bfcalculator createState() => bfcalculator();
}

enum Genders { male, female }

class bfcalculator extends State<BFCalculator> {
  double _age = 20.0, _weight = 150.0;
  int age = 20, weight = 150;

  int heightInt, height1 = 2, height2 = 2;
  int neck1 = 2, neck2 = 2, neckInt, waist1 = 2;
  int waist2 = 2, waistInt, hipInt;
  int hip1 = 2, hip2 = 2;

  bool calculatedScreen = false;

  Genders genders = Genders.male;

  TextEditingController heightFtController = TextEditingController();
  TextEditingController heightInController = TextEditingController();

  TextEditingController neckFtController = TextEditingController();
  TextEditingController neckInController = TextEditingController();

  TextEditingController waistFtController = TextEditingController();
  TextEditingController waistInController = TextEditingController();

  TextEditingController hipFtController = TextEditingController();
  TextEditingController hipInController = TextEditingController();

  List<TextEditingController> vars = [];

  Widget textBox(TextEditingController controller, String text) {
    return Container(
      height: 50,
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (controller == heightFtController) {
            height1 = int.parse(value);
          } else if (controller == heightInController) {
            height2 = int.parse(value);
          } else if (controller == neckFtController) {
            neck1 = int.parse(value);
          } else if (controller == neckInController) {
            neck2 = int.parse(value);
          } else if (controller == waistFtController) {
            waist1 = int.parse(value);
          } else if (controller == waistInController) {
            waist2 = int.parse(value);
          } else if (controller == hipFtController) {
            hip1 = int.parse(value);
          } else if (controller == hipInController) {
            hip2 = int.parse(value);
          }
        },
        decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
        ),
      ),
    );
  }

  Widget calculating() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                SizedBox(width: 120),
                Icon(
                  Mdi.genderMale,
                  color: Colors.lightBlueAccent,
                  size: 40,
                ),
                Radio(
                  value: Genders.male,
                  groupValue: genders,
                  onChanged: (Genders value) {
                    setState(() {
                      genders = value;
                    });
                  },
                ),
                Icon(
                  Mdi.genderFemale,
                  color: Colors.pink[200],
                  size: 40,
                ),
                Radio(
                  value: Genders.female,
                  groupValue: genders,
                  onChanged: (Genders value) {
                    setState(() {
                      genders = value;
                    });
                  },
                ),
              ],
            ),
          ),
          Text("Age",
              style: TextStyle(
                fontSize: 20,
              )),
          Text("$age",
              style: TextStyle(
                fontSize: 20,
              )),
          Slider(
            value: _age,
            min: 14,
            max: 100,
            label: age.toString(),
            onChanged: (double value) {
              setState(() {
                _age = value;
                age = _age.toInt();
              });
            },
          ),
          Text("Weight",
              style: TextStyle(
                fontSize: 20,
              )),
          Text("$weight pounds",
              style: TextStyle(
                fontSize: 20,
              )),
          Slider(
            value: _weight,
            min: 100,
            max: 300,
            label: weight.toString(),
            onChanged: (double value) {
              setState(() {
                _weight = value;
                weight = _weight.toInt();
              });
            },
          ),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Height",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 150,
                child: textBox(heightFtController, "Feet"),
              ),
              SizedBox(width: 20),
              Container(
                width: 150,
                child: textBox(heightInController, "Inches"),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Neck",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 25),
              Container(
                width: 150,
                child: textBox(neckFtController, "Feet"),
              ),
              SizedBox(width: 20),
              Container(
                width: 150,
                child: textBox(neckInController, "Inches"),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 10),
              Text(
                "Waist",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 21),
              Container(
                width: 150,
                child: textBox(waistFtController, "Feet"),
              ),
              SizedBox(width: 20),
              Container(
                width: 150,
                child: textBox(waistInController, 'Inches'),
              )
            ],
          ),
          SizedBox(height: 20),
          Container(
            child: genders == Genders.female
                ? Row(
                    children: [
                      SizedBox(width: 10),
                      Text(
                        "Hip",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 36),
                      Container(
                        width: 150,
                        child: textBox(hipFtController, "Feet"),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 150,
                        child: textBox(hipInController, 'Inches'),
                      )
                    ],
                  )
                : SizedBox(height: 50),
          ),
          SizedBox(height: 20),
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
                          calculate(weight, waistInt, neckInt, 31, Genders.male,
                              heightInt);
                        });
                      },
                      child: Text(
                        "Calculate",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    //deletePrefs();
  }

  Widget build(BuildContext context) {
    heightInt = height1;
    heightInt = 12 * heightInt;
    heightInt = heightInt + height2;

    waistInt = waist1;
    waistInt = 12 * waistInt;
    waistInt = waistInt + waist2;

    neckInt = neck1;
    neckInt = 12 * neckInt;
    neckInt = neckInt + neck2;

    hipInt = hip1;
    hipInt = 12 * hip1;
    hipInt = hipInt + hip2;
    vars = [
      heightInController,
      heightFtController,
      neckInController,
      neckFtController,
      waistInController,
      waistFtController,
      hipInController,
      hipFtController
    ];

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Body Fat Calculator"),
        ),
        drawer: Drawer(
          child: DrawerWidget(),
        ),
        body: calculating());
  }

  void calculate(int weight, waist, neck, hip, gender, height) {
    var _bf, _category;
    setState(() {
      if (gender == Genders.male) {
        Parser p = Parser();
        Expression waistLog, neckLog, tenLog;
        waistLog = Number(waist);
        neckLog = Number(neck);
        tenLog = Number(10);
        Expression log1 = Log(tenLog, waistLog - neckLog);
        Expression exp1 = p.parse("$log1");
        String result1 = exp1.evaluate(EvaluationType.REAL, null).toString();
        double c = double.parse(result1);

        Expression heightLog;
        heightLog = Number(height);
        Expression log2 = Log(tenLog, heightLog);
        Expression exp2 = p.parse("$log2");
        String result2 = exp2.evaluate(EvaluationType.REAL, null).toString();
        double d = double.parse(result2);
        _bf = 86.01 * c - 70.041 * d + 36.76;
        if (_bf <=5.99) {
          _category = "Essential Fat";
        }
        else if (_bf <=13.99 && _bf >= 6.00) {
          _category = "Athletes";
        }
        else if (_bf <=17.99 && _bf >= 14.00) {
          _category = "Fit";
        }
        else if (_bf <=23.99 && _bf >= 18.00) {
          _category = "Acceptable";
        }
        else {
          _category = "Obese";
        }
        setPrefs(_bf, _category);
      } else {
        Parser p = Parser();
        Expression waistLog, neckLog, hipLog, tenLog;
        waistLog = Number(waist);
        neckLog = Number(neck);
        hipLog = Number(hip);
        tenLog = Number(10);
        Expression log1 = Log(tenLog, waistLog + hipLog - neckLog);
        Expression exp1 = p.parse("$log1");
        String result1 = exp1.evaluate(EvaluationType.REAL, null).toString();
        double c = double.parse(result1);

        Expression heightLog;
        heightLog = Number(height);
        Expression log2 = Log(tenLog, heightLog);
        Expression exp2 = p.parse("$log2");
        String result2 = exp2.evaluate(EvaluationType.REAL, null).toString();
        double d = double.parse(result2);
        _bf = 163.205 * c - 97.684 * d + 36.76;
        if (_bf <=5.99) {
          _category = "Essential Fat";
        }
        else if (_bf <=13.99 && _bf >= 6.00) {
          _category = "Athletes";
        }
        else if (_bf <=17.99 && _bf >= 14.00) {
          _category = "Fit";
        }
        else if (_bf <=23.99 && _bf >= 18.00) {
          _category = "Acceptable";
        }
        else {
          _category = "Obese";
        }
        setPrefs(_bf, _category);
      }
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BFCalcScreen()));
    });
  }

  Future <void> setPrefs(var bf, category) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setDouble("bf", bf);
      prefs.setString("category", category);
      print("Prefs: ${prefs.getDouble("bf")}");
    });
  }
}
