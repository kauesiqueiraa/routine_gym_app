import 'package:flutter/material.dart';
import 'package:routine_gym_app/models/goal_model.dart';

class GoalsProvider with ChangeNotifier {
  List<GoalModel> _goals = [];

  List<GoalModel> get goals => _goals;

  void addGoal(GoalModel goal) {
    _goals.add(goal);
    notifyListeners();
  }

  void updateGoal(GoalModel goal) {
    final index = _goals.indexWhere((g) => g.id == goal.id);
    if (index >= 0) {
      _goals[index] = goal;
      notifyListeners();
    }
  }

  void deleteGoal(GoalModel goal) {
    _goals.removeWhere((goal) => goal.id == goal.id);
    notifyListeners();
  }

  void toggleGoalAchieved(String id) {
    final index = _goals.indexWhere((goal) => goal.id == id);
    if (index >= 0) {
      _goals[index].achieved = !_goals[index].achieved;
      notifyListeners();
    }
  }
}