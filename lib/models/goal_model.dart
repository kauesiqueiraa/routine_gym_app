class GoalModel {
  String id;
  String description;
  DateTime targetDate;
  bool achieved;

  GoalModel({
    required this.id,
    required this.description,
    required this.targetDate,
    this.achieved = false,
  });
}