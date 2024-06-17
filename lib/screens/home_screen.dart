import 'package:community_charts_flutter/community_charts_flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/providers/goals_provider.dart';
import 'package:routine_gym_app/providers/workouts_provider.dart';
import 'package:routine_gym_app/screens/add_edit_workout_screen.dart';
import 'package:routine_gym_app/screens/goals_screen.dart';
import 'package:routine_gym_app/screens/performance_screen.dart';
import 'package:routine_gym_app/screens/workout_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutsProvider = Provider.of<WorkoutsProvider>(context);
    final workouts = workoutsProvider.workouts;
    final goalsProvider = Provider.of<GoalsProvider>(context);
    final goals = goalsProvider.goals;

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
                  builder: (ctx) => const GoalsScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(''),
                  ),
                   SizedBox(width: 10),
                  Text('Olá The Boss', 
                  // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            const SizedBox(height: 20),

            const Text(
              'Planejamento da Semana',
              // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.amber,
              ),
              child: Center(
                child: Text('Planejamento da Semana aqui'),
              ),
            ),
              const SizedBox(height: 10),
              const Text('Progresso'),
              const SizedBox(height: 10),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.amber,
                ),
                child: charts.BarChart(
                  PerformanceScreen.withSampleData().seriesList ,
                  animate: true,
                ),
                
              ),
              const SizedBox(height: 20),
              const Text('Metas'),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.amber[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: goals.map((goal) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of( context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const GoalsScreen(),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.all(8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Text(goal.description,
                                  // style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(height: 5),
                                  Text('Até ${goal.targetDate.toLocal().toString().split(' ')[0]}',
                                  // style: const TextStyle(fontSize: 15),
                                  ),
                                  const SizedBox(height: 5),
                                  Checkbox(
                                    value: goal.achieved,
                                    onChanged: (value) {
                                      goalsProvider.toggleGoalAchieved(goal.id);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    ).toList(),
                  ),
                ),
              ),
              // Container(
              //   height: 100,
              //   decoration: BoxDecoration(
              //     color: Colors.amber[100],
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Center(
              //     child: Text('Gráfico simplificado de metas aqui'),
              //   ),
              // ),
              const SizedBox(height: 20),
              const Text('Treinos'),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.fitness_center, color: Colors.amber,),
                      title: Text(workouts[index].name),
                      subtitle: Text(workouts[index].date.toLocal().toString().split(' ')[0]),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => WorkoutDetailsScreen(workout: workouts[index]),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      
      // Consumer<WorkoutsProvider>(
      //   builder: (ctx, workoutsProvider, _) {
      //     final workouts = workoutsProvider.workouts;
      //     return ListView.builder(
      //       itemCount: workouts.length,
      //       itemBuilder: (ctx, index) {
      //         return ListTile(
      //           leading: const Icon(Icons.fitness_center, color: Colors.amber,),
      //           title: Text(workouts[index].name),
      //           subtitle: Text(workouts[index].date.toLocal().toString().split(' ')[0]),
      //           onTap: () {
      //             Navigator.of(context).push(
      //               MaterialPageRoute(
      //                 builder: (ctx) => WorkoutDetailsScreen(workout: workouts[index]),
      //               ),
      //             );
      //           },
      //         );
      //       },
      //     );
      //   },
      // ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const AddEditWorkoutScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                return SlideTransition(
                  position: animation.drive(tween),
                  child: child,
                );
              },
            )
            // MaterialPageRoute(
            //   builder: (ctx) => const AddEditWorkoutScreen(),
            // ),
          );
        },
      )
    );
  }
}