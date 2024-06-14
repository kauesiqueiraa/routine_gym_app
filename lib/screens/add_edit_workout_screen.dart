import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/models/exercise_model.dart';
import 'package:routine_gym_app/models/workout_model.dart';
import 'package:routine_gym_app/providers/workouts_provider.dart';

class AddEditWorkoutScreen extends StatefulWidget {
  final WorkoutModel? workout;

  const AddEditWorkoutScreen({super.key,this.workout});

  @override
  AddEditWorkoutScreenState createState() => AddEditWorkoutScreenState();
}

class AddEditWorkoutScreenState extends State<AddEditWorkoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  List<ExerciseModel> _exercises = [];

  @override
  void initState() {
    super.initState();
    if (widget.workout != null) {
      _nameController.text = widget.workout!.name;
      _dateController.text = widget.workout!.date.toLocal().toString().split(' ')[0];
      _exercises = widget.workout!.exercises;
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newWorkout = WorkoutModel(
        id: widget.workout?.id ?? DateTime.now().toString(),
        name: _nameController.text,
        date: DateTime.parse(_dateController.text),
        exercises: _exercises,
      );
      if (widget.workout != null) {
        Provider.of<WorkoutsProvider>(context, listen: false).addWorkout(newWorkout);
      } else {
        Provider.of<WorkoutsProvider>(context, listen: false).updateWorkout(newWorkout);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout != null ? 'Add Workout' : 'Edit Workout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'WorkoutName'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'WorkoutName is required';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Date is required';
                  }
                  return null;
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _exercises.length,
                  itemBuilder: (ctx, index) {
                    final exercise = _exercises[index];
                    return ListTile(
                      title: Text(exercise.name),
                      subtitle: Text('${exercise.sets} sets x ${exercise.reps} reps @ ${exercise.weight}kg'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _exercises.removeAt(index);
                          });
                        },
                      ),
                    );
                  }
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  
                }, child: const Text('Add Exercise'),
              )
            ],
          )
        ),
      )
    );
  }
        

}