import 'package:flutter/material.dart';
import 'screens/setup_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/summary_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customizable Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => SetupScreen(),
        '/quiz': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return QuizScreen(settings: args);
        },
        '/summary': (context) {
          final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
          return SummaryScreen(
            score: args['score'],
            questions: args['questions'],
            userAnswers: args['userAnswers'],
          );
        },
      },
    );
  }
}
