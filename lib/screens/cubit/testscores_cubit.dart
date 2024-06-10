// ignore_for_file: depend_on_referenced_packages, no_leading_underscores_for_local_identifiers, avoid_print, unused_import, unused_import, duplicate_ignore

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:mapfeature_project/helper/cach_helper.dart';
import 'package:mapfeature_project/screens/cubit/indextask_cubit.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// import '../model.dart';

part 'testscores_state.dart';

class TestscoresCubit extends Cubit<TestscoresState> {
  TestscoresCubit() : super(TestscoresInitial());

  Future<void> fetchData() async {
    // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    // final SharedPreferences prefs = await _prefs;
    // String? token = prefs.getString('token');
    // String? id = prefs.getString('id');
    String? token = CachHelper.getToken();
    String? id = CachHelper.getUserId();
    emit(TestscoresLoading()); // Emit loading state
    final response = await http.get(
      Uri.parse(
          'https://mental-health-ef371ab8b1fd.herokuapp.com/api/testscores/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final testScoresData = jsonData['Testscores'] as List<dynamic>;
      final testScores = testScoresData.map((data) {
        return Testscore.fromJson(data);
      }).toList();
      emit(TestscoresLoaded(testScores: testScores));
      print(response.body);
      print(testScores);
    } else {
      emit(TestscoresError(
          errorMessage: 'Failed to load data: ${response.statusCode}'));
    }
  }
}
