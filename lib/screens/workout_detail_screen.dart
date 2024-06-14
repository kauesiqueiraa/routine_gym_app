import 'package:flutter/material.dart';
import 'package:routine_gym_app/models/workout_model.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutDetailsScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workout.name),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => AddEditWorkoutScreen(workout: workout),
              //   ),
              // );
            }
          )
        ],
      ),
      body: ListView.builder(
        itemCount: workout.exercises.length,
        itemBuilder: (ctx, index) {
          final exercise = workout.exercises[index];
          return ListTile(
            title: Text(exercise.name),
            subtitle: Text('${exercise.sets} sets x ${exercise.reps} reps @ ${exercise.weight}kg'),
          );
        }
      ),
    );
  }
}