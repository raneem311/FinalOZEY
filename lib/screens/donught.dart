// ignore_for_file: depend_on_referenced_packages, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapfeature_project/screens/cubit/indextask_cubit.dart';
import 'package:mapfeature_project/screens/indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class Donought extends StatefulWidget {
  const Donought({
    Key? key,
  }) : super(key: key);

  @override
  State<Donought> createState() => _DonoughtState();
}

class _DonoughtState extends State<Donought> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocProvider(
        create: (context) => IndextaskCubit()..fetchData(),
        //create: (context) => IndextaskCubit(),
        child: BlocBuilder<IndextaskCubit, IndextaskState>(
          builder: (context, state) {
            if (state is IndextaskLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is IndextaskLoaded) {
              final indexTasks = state.indexTasks.first;
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.width * 0.8,
                        child: SfCircularChart(
                          series: <CircularSeries>[
                            DoughnutSeries<ChartData, String>(
                              dataSource: [
                                ChartData(
                                    'Completed',
                                    indexTasks.completed.toDouble(),
                                    const Color(0xff9CAFB3)),
                                ChartData(
                                    'In Progress',
                                    indexTasks.not_completed.toDouble(),
                                    const Color(0xFFBCA5C6)),
                                ChartData(
                                    'Non Completed',
                                    indexTasks.not_completed.toDouble(),
                                    const Color(0xFFBAA9E9)),
                              ],
                              xValueMapper: (ChartData data, _) => data.label,
                              yValueMapper: (ChartData data, _) => data.y,
                              pointColorMapper: (ChartData data, _) =>
                                  data.color,
                              explode: true,
                              explodeAll: true,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                                labelPosition: ChartDataLabelPosition.outside,
                                textStyle: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                          annotations: <CircularChartAnnotation>[
                            CircularChartAnnotation(
                              height: '100%',
                              width: '100%',
                              widget: PhysicalModel(
                                shape: BoxShape.circle,
                                elevation: 10,
                                color: const Color.fromRGBO(230, 230, 230, 1),
                                child: Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 0),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Indicator(
                            key: UniqueKey(),
                            color: const Color(0xFFBAA9E9),
                            text: 'Non Completed',
                            isSquare: false,
                          ),
                          Indicator(
                            key: UniqueKey(),
                            color: const Color(0xFF9CAFB3),
                            text: 'Completed',
                            isSquare: false,
                          ),
                          Indicator(
                            key: UniqueKey(),
                            color: const Color(0xFFBCA5C6),
                            text: 'In Progress',
                            isSquare: false,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 55,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('${indexTasks.Tasks}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey)),
                          Text('${indexTasks.completed}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey)),
                          Text('${indexTasks.not_completed}',
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey)),
                        ],
                      ),
                    ],
                  )
                ],
              );
            } else if (state is IndextaskError) {
              return Center(child: Text(state.errorMessage));
            } else {
              return const Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.label, this.y, this.color);
  final String label;
  final double y;
  final Color color;
}
