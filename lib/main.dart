import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routine_gym_app/providers/goals_provider.dart';
import 'package:routine_gym_app/providers/workouts_provider.dart';
import 'package:routine_gym_app/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => WorkoutsProvider()),
        ChangeNotifierProvider(create: (ctx) => GoalsProvider()),
      ],
      child: MaterialApp(
        title: 'Gym Routine',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          fontFamily: 'Montserrat',
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            bodyLarge: TextStyle(fontSize: 18),
            bodyMedium: TextStyle(fontSize: 16),
            bodySmall: TextStyle(fontSize: 14),
          ),
        
        ),
        home: const HomeScreen(),
      )
    );
  }
}
