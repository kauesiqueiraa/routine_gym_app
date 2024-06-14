import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/models/exercise_model.dart';
import 'package:routine_gym_app/models/workout_model.dart';
import 'package:routine_gym_app/providers/workouts_provider.dart';

class AddEditWorkoutScreen extends StatefulWidget {
  final WorkoutModel? workout;

  const AddEditWorkoutScreen({super.key, this.workout});

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
        Provider.of<WorkoutsProvider>(context, listen: false).updateWorkout(newWorkout);
      } else {
        Provider.of<WorkoutsProvider>(context, listen: false).addWorkout(newWorkout);
      }
      Navigator.of(context).pop();
    }
  }

  void _addExercise() {
    showDialog(
      context: context, 
      builder: (ctx) {
        final _exerciseNameController = TextEditingController();
        final _setsController = TextEditingController();
        final _repsController = TextEditingController();
        final _weightController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Exercise'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _exerciseNameController,
                decoration: const InputDecoration(labelText: 'Exercise Name'),
              ),
              TextFormField(
                controller: _setsController,
                decoration: const InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _repsController,
                decoration: const InputDecoration(labelText: 'Reps'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _weightController,
                decoration: const InputDecoration(labelText: 'Weight (kg)'),
                keyboardType: TextInputType.number,
              ),
            ]
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                final newExercise = ExerciseModel(
                  name: _exerciseNameController.text,
                  sets: int.parse(_setsController.text),
                  reps: int.parse(_repsController.text),
                  weight: double.parse(_weightController.text), 
                  id: '',
                );
                setState(() {
                  _exercises.add(newExercise);
                });
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout != null ? 'Edit Workout' : 'Add Workout'),
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
                decoration: const InputDecoration(labelText: 'Workout Name'),
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
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: widget.workout != null ? widget.workout!.date : DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    _dateController.text = selectedDate.toLocal().toString().split(' ')[0];
                  }
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
                onPressed: _addExercise, 
                child: const Text('Add Exercise'),
              )
            ],
          )
        ),
      )
    );
  }
        

}