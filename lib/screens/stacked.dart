// ignore_for_file: unused_import, duplicate_import, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapfeature_project/screens/cubit/indextask_cubit.dart';
import 'package:mapfeature_project/screens/cubit/testscores_cubit.dart';
import 'package:mapfeature_project/screens/indicator.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class TestScoresPage extends StatelessWidget {
  const TestScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Scores'),
      ),
      body: BlocProvider(
        create: (context) => TestscoresCubit()..fetchData(),
        child: BlocBuilder<TestscoresCubit, TestscoresState>(
          builder: (context, state) {
            if (state is TestscoresLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TestscoresError) {
              return Center(
                child: Text(state.errorMessage),
              );
            } else if (state is TestscoresLoaded) {
              final testScores = state.testScores;
              return Column(
                children: [
                  Expanded(
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0.6,
                      primaryXAxis: CategoryAxis(),
                      series: [
                        StackedColumnSeries<Testscore, String>(
                          width: 0.3,
                          dataSource: testScores!,
                          xValueMapper: (Testscore data, _) => data.date,
                          yValueMapper: (Testscore data, _) =>
                              data.physicalScores,
                          color: const Color(0xFFBCA5C6).withOpacity(0.75),
                        ),
                        StackedColumnSeries<Testscore, String>(
                          width: 0.3,
                          dataSource: testScores,
                          xValueMapper: (Testscore data, _) => data.date,
                          yValueMapper: (Testscore data, _) =>
                              data.mentalScores,
                          color: const Color(0xFFD9D9D9),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // مسافة بين العناصر
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Indicator(
                            key: UniqueKey(),
                            color: const Color(0xFFBCA5C6).withOpacity(.75),
                            text: 'Cognitive-Affective Depressive ',
                            isSquare: false,
                          ),
                          Indicator(
                            key: UniqueKey(),
                            color: const Color(0xFFD9D9D9),
                            text: 'Somatic Depression',
                            isSquare: false,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
