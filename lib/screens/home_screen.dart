import 'package:community_charts_flutter/community_charts_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/providers/workouts_provider.dart';
import 'package:routine_gym_app/screens/add_edit_workout_screen.dart';
import 'package:routine_gym_app/screens/goals_screen.dart';
import 'package:routine_gym_app/screens/performance_screen.dart';
import 'package:routine_gym_app/screens/workout_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gym Routine'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => PerformanceScreen.withSampleData(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.flag),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => GoalsScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: Consumer<WorkoutsProvider>(
        builder: (ctx, workoutsProvider, _) {
          final workouts = workoutsProvider.workouts;
          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (ctx, index) {
              return ListTile(
                title: Text(workouts[index].name),
                subtitle: Text(workouts[index].date.toLocal().toString().split(' ')[0]),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => WorkoutDetailsScreen(workout: workouts[index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddEditWorkoutScreen(),
            ),
          );
        },
      )
    );
  }
}