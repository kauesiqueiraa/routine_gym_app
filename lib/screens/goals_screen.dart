import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/providers/goals_provider.dart';
import 'package:routine_gym_app/screens/add_edit_goal_screen.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Metas'),
      ),
      body: Consumer<GoalsProvider>(
        builder: (ctx, goalsProvider, _) {
          final goals = goalsProvider.goals;
          return ListView.builder(
            itemCount: goals.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(goals[index].description),
                subtitle: Text(goals[index].targetDate.toLocal().toString().split(' ')[0]),
                trailing: Checkbox(
                  value: goals[index].achieved,
                  onChanged: (value) {
                    goalsProvider.toggleGoalAchieved(goals[index].id);
                  },
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddEditGoalScreen(goal: goals[index]),
                    ),
                  );
                },
              );
            }
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditGoalScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}