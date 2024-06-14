import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/models/goal_model.dart';
import 'package:routine_gym_app/providers/goals_provider.dart';

class AddEditGoalScreen extends StatefulWidget {
  final GoalModel? goal;

  const AddEditGoalScreen({Key? key, this.goal}) : super(key: key);

  @override
  _AddEditGoalScreenState createState() => _AddEditGoalScreenState();
}

class _AddEditGoalScreenState extends State<AddEditGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.goal != null) {
      _descriptionController.text = widget.goal!.description;
      _dateController.text = widget.goal!.targetDate.toLocal().toString().split(' ')[0];
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newGoal = GoalModel(
        id: widget.goal?.id ?? DateTime.now().toString(),
        description: _descriptionController.text,
        targetDate: DateTime.parse(_dateController.text),
        achieved: widget.goal?.achieved ?? false,
      );
      if (widget.goal != null) {
        Provider.of<GoalsProvider>(context, listen: false).updateGoal(newGoal);
      } else {
        Provider.of<GoalsProvider>(context, listen: false).addGoal(newGoal);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goal != null ? 'Editar meta' : 'Adcionar meta'),
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
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição de Metas'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Descrição é obrigatória';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Data Final da Meta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Data Final da Meta é obrigatória';
                  }
                  return null;
                },
                onTap: () async {
                  final selectedDate = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (selectedDate != null) {
                    _dateController.text = selectedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
            ]
          ),
        ),
      )
    );
  }

}