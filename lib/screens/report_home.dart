// ignore_for_file: use_full_hex_values_for_flutter_colors, depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mapfeature_project/screens/cubit/indextask_cubit.dart';
import 'package:mapfeature_project/screens/donught.dart';
import 'package:mapfeature_project/screens/line_chart.dart';
import 'package:mapfeature_project/screens/stacked.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import 'package:mapfeature_project/helper/cach_helper.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  bool isLeftPressed1 = true;

  bool _chartPressLeft = true;
  bool _chartPressRight = false;

  bool _circularChartPressLeft = true;
  bool _circularChartPressRight = false;

  late double _percent;

  @override
  void initState() {
    fetchCircleDataLast30Days();
    _percent = 0;
    //fetchCircleDataLast7Days();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Your Monthly Report",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 500,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Statistics",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(height: 1),
                      Row(
                        children: [
                          const Text(
                            "Mood tracker",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(width: 20),
                          Container(
                            height: 60,
                            width: 230,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xfffdce6e3),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    _chartPressLeft = true;
                                    isLeftPressed1 = true;
                                    _chartPressRight = false;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 99,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: _chartPressLeft
                                          ? const Color(0xfff2a5651)
                                          : const Color(0xfffdce6e3),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "30 days",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    _chartPressLeft = false;
                                    isLeftPressed1 = true;
                                    _chartPressRight = true;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 96,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: _chartPressRight
                                          ? const Color(0xfff2a5651)
                                          : const Color(0xfffdce6e3),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "7 days",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ExpenseGraphDesign(
                          isLeftPressed1: isLeftPressed1,
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              //22222222222
              Container(
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Statistics",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      const SizedBox(height: 1),
                      Row(
                        children: [
                          const Text(
                            "Monthly activity",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xFFFDCE6E3),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _circularChartPressLeft = true;
                                      _circularChartPressRight = false;
                                      fetchCircleDataLast30Days();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        //color: isLeftPressed2
                                        color: _circularChartPressLeft
                                            ? const Color(0xFFF2A5651)
                                            : const Color(0xFFFDCE6E3),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "30 days",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _circularChartPressRight = true;
                                      _circularChartPressLeft = false;
                                      fetchCircleDataLast7Days();
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        //color: isLeftPressed2
                                        color: _circularChartPressRight
                                            ? const Color(0xFFF2A5651)
                                            : const Color(0xFFFDCE6E3),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "7 days",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: 100.0,
                            lineWidth: 20.0,
                            animationDuration: 1800,
                            percent: _percent,
                            arcType: ArcType.HALF,
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: Colors.grey,
                            center: Text(
                              '${(_percent.isFinite ? (_percent * 100).toInt() : 0)}%\n tasks',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            progressColor: const Color(0xFF8CBAB1),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //33333333333333333
              Container(
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Statistics",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Monthly activity",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: Donought(),
                      ),

                      // Add your other widgets here
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //4444444444444444444
              Container(
                height: 500,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Statistics",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      SizedBox(height: 1),
                      Text(
                        "Test Activty",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: TestScoresPage(),
                      ),
                      // Add your other widgets here
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fetchCircleDataLast30Days() async {
    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;

    // String? token = prefs.getString('token');
    String? token = CachHelper.getToken();
    // String? id = prefs.getString('id');
    String id = CachHelper.getUserId();
    final response = await http.get(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/taskalast30days/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      if (responseData is Map<String, dynamic>) {
        final List<IndexTasks> indexTasks = [
          IndexTasks.fromJson(responseData)
        ]; // Create a list with a single object
        print(indexTasks[0].Tasks);
        print(indexTasks[0].completed);
        print(indexTasks[0].not_completed);

        _percent = (indexTasks[0].completed / indexTasks[0].Tasks).clamp(0, 1);
        print(_percent);
        setState(() {});
        // Emit loaded state with data
      } else {
        print('Unexpected response body format: $responseData');
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  fetchCircleDataLast7Days() async {
    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    // String? token = prefs.getString('token');
    // String? id = prefs.getString('id');
    String? id = CachHelper.getUserId();
    String? token = CachHelper.getToken();
    // print(token);
    // print(id);
    // print("ttttttttttttttttttttttttttttttttt");
    final response = await http.get(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/taskslast7days/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final dynamic responseData = jsonDecode(response.body);
      if (responseData is Map<String, dynamic>) {
        print(responseData);
        final List<IndexTasks> indexTasks = [
          IndexTasks.fromJson(responseData)
        ]; // Create a list with a single object
        // print(indexTasks[0].Tasks);
        // print(indexTasks[0].completed);
        // print(indexTasks[0].not_completed);
        _percent = (indexTasks[0].completed / indexTasks[0].Tasks).clamp(0, 1);
        // _percent = 0.3;
        // print(_percent);
        // setState(() {});
        setState(() {});

        // Emit loaded state with data
      } else {
        print('Unexpected response body format: $responseData');
        //_percent = 0.3;
        //setState(() {});
        throw Exception('Unexpected response format');
      }
    } else {
      //_percent = 0.3;
      //setState(() {});
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
