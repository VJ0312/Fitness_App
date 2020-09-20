import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'History.dart';
import 'Drawer.dart';
import 'WeighLog.dart';

bool noData = false;
class Graph extends StatefulWidget {
  GraphState createState() => GraphState();
}

class GraphState extends State<Graph> {
  void initState() {
    super.initState();
    for (int i = 0; i<=entryList.length - 1; i++) {
      addToGraph(i);
    }
    noData = entryList.length-1 < 1? true : false;
  }

  List<History> data = [
  ];

  void addToGraph(var index) {
      data.add(History(
      day: entryList[index].day,
      weight: entryList[index].weight,
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Monthly Graph")),
      drawer: Drawer(
        child: DrawerWidget(),
      ),
      body: !noData? _Graph(data: data) : Center(
       child: Text(
            "No data", style: TextStyle(
         fontSize: 40,
       ),
        ),
      )
    );
  }
}

class _Graph extends StatelessWidget {
  final List<History> data;
  _Graph({this.data});
  @override
  Widget build(BuildContext context) {
    List<chart.Series<History, String>> series = [
      chart.Series(
        id: "Date",
        data: data,
        measureLowerBoundFn: (History history, _) => 140,
        measureUpperBoundFn: (History history, _) => 180,
        domainFn: (History history, _) => history.day.toString(),
        measureFn: (History history, _) => history.weight,
      ),
    ];
    return chart.BarChart(series, animate: true);
  }
}
