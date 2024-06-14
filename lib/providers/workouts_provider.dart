import 'package:flutter/material.dart';
import 'package:routine_gym_app/models/workout_model.dart';

class WorkoutsProvider with ChangeNotifier {
  List<WorkoutModel> _workouts = [];

  List<WorkoutModel> get workouts => _workouts;

  void addWorkout(WorkoutModel workout) {
      _workouts.add(workout);
      notifyListeners();
    }

  void updateWorkout(WorkoutModel workout) {
    final index = _workouts.indexWhere((w) => w.id == workout.id);
    if (index >= 0) {
      _workouts[index] = workout;
      notifyListeners();
    }
  }

  void deleteWorkout(String id) {
    _workouts.removeWhere((workout) => workout.id == id);
    notifyListeners();
  }
}