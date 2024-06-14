import 'package:flutter/material.dart';
import 'package:routine_gym_app/models/workout_model.dart';

class WorkoutsProvider with ChangeNotifier {
  final List<WorkoutModel> _workouts = [];

  List<WorkoutModel> get workouts => _workouts;

  void addWorkout(WorkoutModel workoutModel) {
    final index = _workouts.indexWhere((w) => w.id == workoutModel.id);
    if (index >= 0) {
      _workouts[index] = workoutModel;
      notifyListeners();
    }
  }

  void updateWorkout(WorkoutModel workoutModel) {
    final index = _workouts.indexWhere((w) => w.id == workoutModel.id);
    if (index >= 0) {
      _workouts[index] = workoutModel;
      notifyListeners();
    }
  }

  void deleteWorkout(String id) {
    _workouts.removeWhere((workout) => workout.id == id);
    notifyListeners();
  }
}