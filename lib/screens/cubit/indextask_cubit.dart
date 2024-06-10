// ignore_for_file: depend_on_referenced_packages, avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:mapfeature_project/helper/cach_helper.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
// import '../model.dart';

part 'indextask_state.dart';

class IndextaskCubit extends Cubit<IndextaskState> {
  IndextaskCubit() : super(IndextaskInitial());

  Future<void> fetchData() async {
    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    // String? token = prefs.getString('token');
    // String? id = prefs.getString('id');
    String? token = CachHelper.getToken();
    String? id = CachHelper.getUserId();
    emit(IndextaskLoading()); // Emit loading state

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
        emit(IndextaskLoaded(indexTasks));
        print(indexTasks[0].Tasks);
        print("len ${indexTasks.length}");
        print("len ${indexTasks[0].completed}");
        print("len ${indexTasks[0].not_completed}");
        for (int i = 0; i < indexTasks.length; i++) {
          print('loop');
          print(indexTasks[i].completed);
          print(indexTasks[i].not_completed);
          print(indexTasks[0].Tasks);
        }
        // Emit loaded state with data
      } else {
        print('Unexpected response body format: $responseData');
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}

class IndexTasks {
  final int Tasks;
  final int completed;
  final int not_completed;
  IndexTasks({
    required this.Tasks,
    required this.completed,
    required this.not_completed,
  });
  factory IndexTasks.fromJson(Map<String, dynamic> json) {
    return IndexTasks(
        Tasks: json['Tasks'],
        completed: json['completed'],
        not_completed: json['not_completed']);
  }
}

class Testscore {
  int totalScores;
  int physicalScores;
  int mentalScores;
  String date;

  Testscore(
      {required this.totalScores,
      required this.physicalScores,
      required this.mentalScores,
      required this.date});

  factory Testscore.fromJson(Map<String, dynamic> json) {
    return Testscore(
        totalScores: json['totalscores'],
        physicalScores: json['phyicalscores'],
        mentalScores: json['mentalscores'],
        date: json['date']);
  }
}
