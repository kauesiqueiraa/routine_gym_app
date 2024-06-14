import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';

class PerformanceScreen extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  final bool animate;

  const PerformanceScreen(this.seriesList, {super.key, this.animate = false});

  factory PerformanceScreen.withSampleData() {
    return PerformanceScreen(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance'),
      ),
      body: Center(
        child: charts.BarChart(
          seriesList,
          animate: animate,
        ),
      )
    );
  }

  static List<charts.Series<ExercisePerformance, String>> _createSampleData() {
    final data = [
      ExercisePerformance('Squats', 5),
      ExercisePerformance('Push-ups', 10),
      ExercisePerformance('Pull-ups', 15),
      ExercisePerformance('Lunges', 20),
      ExercisePerformance('Planks', 25),
    ];

    return [
      charts.Series<ExercisePerformance, String>(
        id: 'Performance',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ExercisePerformance performance, _) => performance.exercise,
        measureFn: (ExercisePerformance performance, _) => performance.score,
        data: data,
      )
    ];
  }
}

class ExercisePerformance {
  final String exercise;
  final int score;

  ExercisePerformance(this.exercise, this.score);
}