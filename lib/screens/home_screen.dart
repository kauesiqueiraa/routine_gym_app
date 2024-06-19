import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/providers/goals_provider.dart';
import 'package:routine_gym_app/providers/workouts_provider.dart';
import 'package:routine_gym_app/screens/add_edit_workout_screen.dart';
import 'package:routine_gym_app/screens/goals_screen.dart';
import 'package:routine_gym_app/screens/performance_screen.dart';
import 'package:routine_gym_app/screens/workout_detail_screen.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutsProvider = Provider.of<WorkoutsProvider>(context);
    final workouts = workoutsProvider.workouts;
    final goalsProvider = Provider.of<GoalsProvider>(context);
    final goals = goalsProvider.goals;

    double completedGoals =
        goals.where((goal) => goal.achieved).length.toDouble();
    double totalGoals = goals.length.toDouble();
    double progress = totalGoals == 0 ? 0 : (completedGoals / totalGoals) * 100;

    // dias da semana
    List<String> weekDays = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime day = now.add(Duration(days: i));
      weekDays.add(DateFormat('EEEE', 'pt_BR').format(day));
    }

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
                      radius: 20,
                      backgroundImage: AssetImage(''),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Olá The Boss',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      padding:  const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.orange[500],
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
                      ),
                      child: Text(
                        DateFormat('MMMM', 'pt_BR')
                            .format(now), // Nome do mês em português
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                        width:
                            20), // Espaço entre o nome do mês e os dias da semana
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: weekDays.map((day) {
                            int dayIndex = weekDays.indexOf(day) - 7;
                            DateTime date = now.add(Duration(days: dayIndex));
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  Text(
                                    day.substring(0,
                                        3), // Exibe os primeiros 3 caracteres do dia (por exemplo, Seg, Ter)
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.orange[400],
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${date.day}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                const Text(
                  'Treino Personalizado',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange[400],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Opacity(
                          opacity: 0.9,
                          child: Image.asset(
                            'assets/images/force.png',
                            width: 100, 
                            height: 80,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Nome do Treino aqui', 
                                  style:TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)
                                ),
                                const SizedBox(height: 10),
                                // a porcentagem de progresso aqui
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Progresso ${progress.toStringAsFixed(1)}%', style: const TextStyle(fontSize: 15, color: Colors.white)),
                                const SizedBox(height: 10),
                                // uma barra de progresso aqui
                                Container(
                                  width: 200,
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                                  ),
                                )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(Icons.more_vert_rounded, color: Colors.white),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                // const Text(
                //   'Progresso',
                //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 10),
                // Container(
                //   height: 200,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: Colors.amber,
                //   ),
                //   child: Center(
                //     child: PieChart(
                //       PieChartData(
                //         sections: [
                //           PieChartSectionData(
                //             value: progress,
                //             title: '${progress.toStringAsFixed(1)}%',
                //             color: Colors.green,
                //             radius: 30,
                //             titleStyle: TextStyle(
                //               fontSize: 18,
                //               fontWeight: FontWeight.bold,
                //               color: Colors.white,
                //             ),
                //           ),
                //           PieChartSectionData(
                //             value: 100 - progress,
                //             title: '',
                //             color: Colors.grey[300],
                //             radius: 30,
                //           ),
                //         ],
                //         centerSpaceRadius: 20,
                //         sectionsSpace: 0,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Metas',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[400],
                        shape: const CircleBorder(),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const GoalsScreen(),
                          ),
                        );
                      }, 
                      child: const Icon(Icons.add, color: Colors.white, size: 30,),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange[400],
                  ),
                  child: Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: goals.map((goal) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const GoalsScreen(),
                                ),
                              );
                            },
                            child: SizedBox(
                              width: 150,
                              child: Card(
                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                color: Colors.white,
                                borderOnForeground: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        goal.description,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      const SizedBox(height: 5),
                                      // Text(
                                      //   'Até ${goal.targetDate.toLocal().toString().split(' ')[0]}',
                                      //   style: const TextStyle(fontSize: 15),
                                      // ),
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
                            ),
                          );
                        }).toList(),
                      ),
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
                const Text(
                  'Treinos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: workouts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.fitness_center,
                          color: Colors.amber,
                        ),
                        title: Text(workouts[index].name),
                        subtitle: Text(workouts[index]
                            .date
                            .toLocal()
                            .toString()
                            .split(' ')[0]),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => WorkoutDetailsScreen(
                                  workout: workouts[index]),
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
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const AddEditWorkoutScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.ease;

                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));

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
        ));
  }
}
