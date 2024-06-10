// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_brace_in_string_interps, avoid_print, prefer_typing_uninitialized_variables, unused_element, use_key_in_widget_constructors, depend_on_referenced_packages, unused_import, unused_field, unused_local_variable

import 'dart:convert';

import 'package:calendar_timeline_sbk/calendar_timeline.dart';

import 'package:flutter/material.dart';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mapfeature_project/Todo/databasehelper.dart';
import 'package:mapfeature_project/Todo/event_model.dart';
import 'package:mapfeature_project/helper/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../helper/allTasks_response.dart';

// import 'package:todo3/databasehelper.dart';

// import 'package:soothe-bot/Todo/event_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<bool> _isCompleted = [];
  DateTime _selectedDate = DateTime.now();
  late TimeOfDay _selectedStartTime;
  late TimeOfDay _selectedEndTime;
  late String _eventName = '';
  late TextEditingController _eventNameController;
  late TextEditingController _eventDateController;
  late TextEditingController _selectedStartTimeController;
  late TextEditingController _selectedEndTimeController;
  //List<EventModel> events = [];
  Future? _future;
  List<AllTasksResponse>? taskData;

  final bool _isCompletedTask = false;

  // Future<void> getAllEvents() async {
  //   events = await DBHelper.db.getAllEvents();
  //   _isCompleted = List.generate(events.length, (index) => false);
  //   setState(() {});
  // }

  List<AllTasksResponse> getTasksByCalenderDate() {
    List<AllTasksResponse> selectedTasks = [];
    List<AllTasksResponse> tasks = taskData ?? [];

    for (var task in tasks) {
      DateTime taskDate = DateTime.parse(task.date!.toString());
      DateTime deadline = DateTime(taskDate.year, taskDate.month, taskDate.day);
      if (deadline == _selectedDate) {
        selectedTasks.add(task);
      }
    }
    for (var task in tasks) {
      _isCompleted.add(false);
    }
    return selectedTasks;
  }

  Future<void> addTask() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('token');
    String? id = prefs.getString('id');
    TimeOfDay startTime = TimeOfDay(
        hour: _selectedStartTime.hour, minute: _selectedStartTime.minute);
    TimeOfDay endTime =
        TimeOfDay(hour: _selectedEndTime.hour, minute: _selectedEndTime.minute);
    String formattedTime = startTime.format(context);
    String eTime = endTime.format(context);
    print(id);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    http.Response response = await http.post(
        Uri.parse(
            'https://mental-health-ef371ab8b1fd.herokuapp.com/api/store_task'),
        headers: headers,
        body: {
          "taskname": _eventNameController.text,
          "date": DateFormat('yyyy-MM-dd').format(_selectedDate).toString(),
          "firsttime": formattedTime,
          "endtime": eTime,
          "user_id": id
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      if (context.mounted) {
        allTasks();
        Navigator.of(context).pop();
      }
      // if (context.mounted) {
      //
      //   Navigator.of(context).pop();
      // }
    } else {
      print(response.body);
    }
  }
  allTasks() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('token');
    String? id = prefs.getString('id');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    http.Response response = await http.get(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/tasks/$id'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      print(jsonResponse[0].toString());
      List<AllTasksResponse> items =
          jsonResponse.map((item) => AllTasksResponse.fromJson(item)).toList();
      //print(items.length);
      print(items[0].completed);
      setState(() {
        taskData = items;
      });
      getTasksByCalenderDate();
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    tz.initializeTimeZones();
    super.initState();
    allTasks();
    _resetSelectedDate();
    _resetSelectedTime();
    _eventNameController = TextEditingController();
    _selectedStartTimeController = TextEditingController();
    _selectedEndTimeController = TextEditingController();
    _eventDateController = TextEditingController();
    // _future = getAllEvents();
  }

  var date;

  void _resetSelectedDate() {}

  void _resetSelectedTime() {
    _selectedStartTime = TimeOfDay.now();
    _selectedEndTime = TimeOfDay.now();
  }

  void _showEventDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Event'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 40),
              TextField(
                onChanged: (value) => _eventName = value,
                controller: _eventNameController,
                decoration: InputDecoration(
                  // hintText: 'Your Event Name',
                  // hintStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color:Color(0xFF61A0A6) ),labelText: 'Event Name',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(200),
                    borderSide: const BorderSide(color: Color(0xFF61A0A6)),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 1.0, horizontal: 50),
                ),
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              TextFormField(
                onTap: () => _selectDate(context),
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Date',
                  labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(200)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 1.0, horizontal: 50),
                ),
                controller: TextEditingController(
                    text: DateFormat('yyyy-MM-dd').format(_selectedDate)),
              ),
              const SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      onTap: () => _selectStartTime(context),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Start Time',
                        labelStyle: const TextStyle(
                          color: Color.fromARGB(255, 15, 10, 10),
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(200)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 20),
                      ),
                      controller: _selectedStartTimeController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      onTap: () => _selectEndTime(context),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'End Time',
                        labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(200)),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 25),
                      ),
                      controller: _selectedEndTimeController,
                    ),
                  ),
                ],
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الحوار بدون حفظ
              },
              child: const Text('Cancel'), // إضافة معلمة الطفرة هنا
            ),
            ElevatedButton(
              onPressed: () async {
                addTask();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showEventDetails(Map<String, dynamic> responseData) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Event Details',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text('Event Name: $_eventName',
                  style: const TextStyle(fontSize: 16)),
              Text('Start Time: ${_selectedStartTime.format(context)}',
                  style: const TextStyle(fontSize: 16)),
              Text('End Time: ${_selectedEndTime.format(context)}',
                  style: const TextStyle(fontSize: 16)),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _eventDateController.text =
            DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedStartTime = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );

    if (pickedStartTime != null && pickedStartTime != _selectedStartTime) {
      setState(() {
        _selectedStartTime = pickedStartTime;
        _selectedStartTimeController.text = pickedStartTime.format(context);
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedEndTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (pickedEndTime != null && pickedEndTime != _selectedEndTime) {
      setState(() {
        _selectedEndTime = pickedEndTime;
        _selectedEndTimeController.text = pickedEndTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //((((((((((( getAllEvents(); <--- not necessary)))))))))))
    return Scaffold(
     backgroundColor: Color.fromARGB(255, 220, 223, 225),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 220, 223, 225),
         title: const Text(
          'All Tasks List',
          style: TextStyle(
              fontFamily: AlegreyaFont,
             color: Color(0xff1F5D6B),
              fontWeight: FontWeight.w900,
              fontSize: 26),
        ),
        centerTitle: true,
        
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 350,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: CalendarTimeline(
                      showYears: false,
                      initialDate: _selectedDate,
                      firstDate: DateTime.now(),
                      lastDate:
                          DateTime.now().add(const Duration(days: 365 * 4)),
                      onDateSelected: (date) =>
                          setState(() => _selectedDate = date),
                      dotsColor: const Color(0xFF61A0A6),
                      dayColor: const Color(0xFF555B5C),
                      dayNameColor: Colors.white,
                      activeDayColor: Colors.white,
                      inactiveDayNameColor: Colors.black,
                      activeBackgroundDayColor: const Color(0xFF61A0A6),
                      selectableDayPredicate: (date) => true,
                      locale: 'en',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              //taskData == null
              getTasksByCalenderDate().isEmpty
                  ? const Center(
                      child: Text('No Tasks'),
                    )
                  //: taskData == null
                  : getTasksByCalenderDate().isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: 500,
                          child: FutureBuilder(
                            future: allTasks(),
                            builder: (context,snapshot) {
                              return ListView.separated(
                                itemCount: getTasksByCalenderDate().length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0, right: 15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF8FA5A8),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 100,
                                      width: 350,
                                      padding: const EdgeInsets.all(5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                getTasksByCalenderDate()[index]
                                                    .taskname!,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              subtitle: Text(
                                                'Time :${getTasksByCalenderDate()[index].firsttime} - ${getTasksByCalenderDate()![index].endtime}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  print(getTasksByCalenderDate()[
                                                          index]
                                                      .id);
                                                  makeTaskStateTrue(
                                                      taskId:
                                                          getTasksByCalenderDate()[
                                                                  index]
                                                              .id!
                                                              .toInt(),
                                                      index: index);
                                                  setState(() {});
                                                },
                                                child:
                                                    getTasksByCalenderDate()[index]
                                                            .completed!
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                          )
                                                        : const Icon(
                                                            Icons.check_circle,
                                                            color: Colors.white,
                                                          ),
                                              ),
                                              const SizedBox(width: 10),
                                              GestureDetector(
                                                onTap: () {
                                                  deleteTask(
                                                      taskId:
                                                          getTasksByCalenderDate()[
                                                                  index]
                                                              .id!
                                                              .toInt(),
                                                      index: index);
                                                  // _deleteEvent(index);
                                                  // حذف الحدث عند النقر على أيقونة السلة},
                                                },
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                              );
                            },
                          ),
                        ),
              const SizedBox(height: 10),
              Center(
                child: FloatingActionButton(
                  onPressed: _showEventDialog,
                  backgroundColor:
                      const Color(0xFF61A0A6), // عرض الحوار عند الضغط
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  makeTaskStateTrue({required int taskId, required int index}) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('token');
    String? id = prefs.getString('id');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({"id": taskId, "completed": 1});
    try {
      http.Response response = await http.post(
        Uri.parse(
            'https://mental-health-ef371ab8b1fd.herokuapp.com/api/tskcompleted'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        //print(response.body);
        print('Task Completed');
        setState(() {
          getTasksByCalenderDate()[index].completed = true;
        });
      } else {
        print(response.reasonPhrase);
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  deleteTask({required int taskId, required int index}) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString('token');
    String? id = prefs.getString('id');

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({"id": taskId, "completed": 1});

    try {
      http.Response response = await http.delete(
        Uri.parse(
            'https://mental-health-ef371ab8b1fd.herokuapp.com/api/deletetask/$taskId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        print(response.body);
        print('Task Completed');
        setState(() {
          getTasksByCalenderDate().removeAt(index);
        });
        setState(() {});
      } else {
        print(response.reasonPhrase);
        print(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}