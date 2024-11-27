import 'package:flutter/material.dart';
import '../models/question.dart';

class SummaryScreen extends StatelessWidget {
  final int score;
  final List<Question> questions;
  final List<String?> userAnswers;

  const SummaryScreen({
    required this.score,
    required this.questions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Score: $score/${questions.length}',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  final userAnswer = userAnswers[index];
                  final isCorrect = userAnswer == question.correctAnswer;
                  return Card(
                    color: isCorrect ? Colors.green[100] : Colors.red[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Q${index + 1}: ${question.question}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text('Your Answer: ${userAnswer ?? "No Answer"}'),
                          Text('Correct Answer: ${question.correctAnswer}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Retake Quiz'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              child: Text('Back to Setup'),
            ),
          ],
        ),
      ),
    );
  }
}
