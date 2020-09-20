import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'Drawer.dart';

int clicks = 0;

class Variables {
  double lowest = 80.0;
  double highest = 400.0;

  String startValue = "Date";

  int length = 3;
  Variables({this.lowest, this.highest});
}

List<Entry> entryList = [];

class Entry {
  int day;
  int month;
  int year;

  double weight = 150.0;

  Entry(this.day, this.month, this.year, this.weight);
}

class WeightEntries extends StatefulWidget {
  weightEntries createState() => weightEntries();
}

//ignore: camel_case_types
class weightEntries extends State<WeightEntries> {
  final snackBar = SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.black,
      content: Text("Entry Deleted",
          style: TextStyle(fontSize: 15)));
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
              child: Padding(
        padding: EdgeInsets.only(left: 80),
        child: Text('Weight Log'),
      ))),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: createDialog,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Container(
                child: ListView.builder(
                    itemCount: entryList.length,
                    itemBuilder: (context, index) {
                      final entry = entryList[index];
                      return Dismissible(
                          key: ObjectKey(entry),
                          child: entryWidget(index, entry),
                          onDismissed: (direction) {
                            setState(() {
                              handleDismissed(direction, index);
                              Scaffold.of(context).showSnackBar(snackBar);
                              personalBest(index);
                            });
                          });
                      // return
                    })),
          )
        ],
      ),
    );
  }

  void initState() {
    super.initState();
    clicks++;
    if (clicks < 2) {
      if (entryList.length < 1) {
        addItem(2, 9, 2020, 150.0);
      }
      if (entryList.length < 2) {
        addItem(3, 9, 2020, 153.0);
      }
    }
  }

  void handleDismissed(var direction, index) {
    setState(() {});
    if (direction == DismissDirection.startToEnd) {
      if (entryList.contains(entryList.removeAt(index))) {
        setState(() {
          entryList.remove(entryList.removeAt(index));
        });
      }
      setState(() {});
    }
  }

  void personalBest(int index) {
    for (int i = 0; i <= entryList.length; i++) {
      if (Variables().highest < entryList[i].weight) {
        Variables().highest = entryList[i].weight.toDouble();
      }
      if (Variables().lowest > entryList[i].weight.toDouble()) {
        Variables().lowest = entryList[i].weight.toDouble();
      }
    }
  }

  void addItem(var day, month, year, weight) {
    entryList.add(Entry(day, month, year, weight));
  }


   Future <void> createDialog() async {
    int day, month, year;

    var weightTens, weightZeros, weightDouble;

    showPickerNumber(BuildContext context) {
      Picker(
          adapter: NumberPickerAdapter(data: [
            NumberPickerColumn(begin: 80, end: 400,
            ),
            NumberPickerColumn(begin: 0, end: 9, jump: 1),
          ]),
          delimiter: [
            PickerDelimiter(child: Container(
              width: 30.0,
              alignment: Alignment.center,
              child: Icon(Icons.more_vert),
            ))
          ],
          hideHeader: true,
          title: Text("Please Select"),
          selectedTextStyle: TextStyle(color: Colors.blue),
          onConfirm: (Picker picker, List value) {
            weightTens = picker.getSelectedValues()[0];
            weightZeros = picker.getSelectedValues()[1];
            weightDouble = weightTens + 0.1 * weightZeros;
            print(weightDouble);
          }
      ).showDialog(context);
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "New Entry",
              style: TextStyle(fontFamily: "Oswald"),
            ),
            content: SingleChildScrollView(
              child: Column(children: <Widget>[
                RaisedButton(
                  child: Text("Pick Date"),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2021))
                        .then((date) {
                      setState(() {
                        day = date.day;
                        month = date.month;
                        year = date.year;
                      });
                    });
                  },
                ),
                RaisedButton(
                  child: Text(
                    "Select Weight"
                  ),
                  onPressed: () {
                    showPickerNumber(context);
                  },
                ),
                MaterialButton(
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (weightDouble == null) {
                        weightDouble = 150.0;
                      }
                      if (day == null) {
                        day = DateTime.now().day;
                      }
                      else if (month == null) {
                        day = DateTime.now().month;
                      }
                      else if (year == null) {
                        day = DateTime.now().year;
                      }
                      weightEntries().addItem(day, month, year, weightDouble);
                      Navigator.pop(context);
                    });
                  },
                )
              ]),
            ),
          );
        }
        );
  Future<void> getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    entryList.length = prefs.getInt("items" ?? 1);
  }

  }

  Future<void> setPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt("items", entryList.length);
  }

  Widget entryWidget(int index, var entry) {
    return Card(
      child: ListTile(
          leading: Container(
            width: 250,
            child: Text("${entry.day}/${entry.month}/${entry.year}",
                style: TextStyle(
                  fontSize: 17,
                )),
          ),
          trailing: Container(
            width: 50,
            child: Text("${entryList[index].weight}",
                style: TextStyle(
                  fontSize: 17,
                )),
          )),
    );
  }
}
