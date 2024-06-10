// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:mapfeature_project/helper/cach_helper.dart';

class ExpenseGraphDesign extends StatefulWidget {
  final bool isLeftPressed1;

  const ExpenseGraphDesign({Key? key, required this.isLeftPressed1})
      : super(key: key);

  @override
  State<ExpenseGraphDesign> createState() => _ExpenseGraphDesignState();
}

class _ExpenseGraphDesignState extends State<ExpenseGraphDesign> {
  late List<FlSpot> spots;

  // List<FlSpot>? _getDaysSpots;
  // TODO: implement _get30DaysSpot
  // Implementation for 30 days spots

  List<FlSpot>? _get7DaysSpots;
  List<FlSpot>? _get30DaysSpots;

  getEmojes7dayes() async {
    print('getEmojes7dayes');

    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    // String? token = prefs.getString('token');
    // String? id = prefs.getString('id');
    String? token = CachHelper.getToken();
    String? id = CachHelper.getUserId();
    int userId = int.parse(id);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.get(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/moodlast7days/$userId'),
      headers: headers,
    );

    print("body : ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print('data ret ${data['Very Happy'].toString()}');
      List<FlSpot> get7() {
        // Implementation for 30 days spots
        return [
          FlSpot(1.0, data['Very Happy'].toDouble()),
          FlSpot(2.0, data['Happy'].toDouble()),
          FlSpot(3.0, data['Natural'].toDouble()),
          FlSpot(4.0, data['Sad'].toDouble()),
          FlSpot(5.0, data['Very Sad'].toDouble()),
        ];
      }

      //_get7DaysSpots = get7();
      _get7DaysSpots = List.from(get7());
      spots = _get7DaysSpots!;
      print('7 day ${response.body}');
      //setState(() {});
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);
    }
  }

  getEmojes30dayes() async {
    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    // String? token = prefs.getString('token');
    // String? id = prefs.getString('id');
    String? token = CachHelper.getToken();
    String? id = CachHelper.getUserId();
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.get(
        Uri.parse(
            'https://mental-health-ef371ab8b1fd.herokuapp.com/api/moodlast30days/$id'),
        headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      print(data);
      List<FlSpot> get30() {
        // Implementation for 30 days spots
        return [
          FlSpot(1, data['Very Happy'].toDouble()),
          FlSpot(2, data['Happy'].toDouble()),
          FlSpot(3, data['Natural'].toDouble()),
          FlSpot(4, data['Sad'].toDouble()),
          FlSpot(5, data['Very Sad'].toDouble()),
        ];
      }

      _get30DaysSpots = List.from(get30());
      spots = _get30DaysSpots!;
      print('30 day ${response.body}');
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isLeftPressed1) {
        getEmojes30dayes();
      } else {
        getEmojes7dayes();
      }
    });
    super.initState();
    // spots = widget.isLeftPressed1 ? _getDaysSpots! : _get7DaysSpots!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.isLeftPressed1 ? getEmojes30dayes() : getEmojes7dayes(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          // If there is an error, display it
          return const Center(child: Text('Error loading data'));
        } else {
          // If the Future is complete, display the data
          return _get30DaysSpots == null
              ? const Center(
                  child: Text('No Data'),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          LineChart(
                            LineChartData(
                              minX: 1,
                              maxX: 5,
                              minY: 0,
                              maxY: 7,
                              lineBarsData: [
                                LineChartBarData(
                                  spots: spots,
                                  isCurved: true,
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF8CBAB1),
                                      Color(0xff6f958e)
                                    ],
                                  ),
                                  barWidth: 3,
                                  belowBarData: BarAreaData(
                                    show: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFF418675).withOpacity(.2),
                                        const Color(0xffAEDCD5).withOpacity(.2),
                                        const Color(0xffFFFFFF).withOpacity(.2),
                                      ],
                                    ),
                                  ),
                                  dotData: const FlDotData(show: false),
                                ),
                              ],
                              gridData: FlGridData(
                                show: true,
                                drawHorizontalLine: false,
                                drawVerticalLine: true,
                                getDrawingVerticalLine: (value) {
                                  return const FlLine(
                                    color: Colors.white,
                                    strokeWidth: 0.8,
                                  );
                                },
                              ),
                              titlesData: FlTitlesData(
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    reservedSize: 12,
                                    getTitlesWidget: (value, meta) {
                                      String text = '';
                                      switch (value.toInt()) {
                                        case 1:
                                          text = "1";
                                          break;
                                        case 2:
                                          text = "2";
                                          break;
                                        case 3:
                                          text = "3";
                                          break;
                                        case 4:
                                          text = "4";
                                          break;
                                        case 5:
                                          text = "5";
                                          break;
                                        default:
                                          return Container();
                                      }
                                      return Text(
                                        text,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.all(5.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 0),
                                    child: Icon(
                                      Icons.sentiment_very_satisfied,
                                      color: Color(0xFF8CBAB1),
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 38),
                                  Icon(
                                    Icons.sentiment_satisfied,
                                    color: Color(0xFF8CBAB1),
                                    size: 25,
                                  ),
                                  SizedBox(width: 68),
                                  Icon(
                                    Icons.sentiment_neutral,
                                    color: Color(0xFF8CBAB1),
                                    size: 25,
                                  ),
                                  SizedBox(width: 64),
                                  Icon(
                                    Icons.sentiment_dissatisfied,
                                    color: Color(0xFF8CBAB1),
                                    size: 25,
                                  ),
                                  SizedBox(width: 45),
                                  Icon(
                                    Icons.sentiment_very_dissatisfied,
                                    color: Color(0xFF8CBAB1),
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        }
      },
    );
  }
}
