import 'package:routine_gym_app/models/exercise_model.dart';

class WorkoutModel {
  String id;
  String name;
  List<ExerciseModel> exercises;
  DateTime date;

  WorkoutModel({
    required this.id,
    required this.name,
    required this.exercises,
    required this.date,
  });
}