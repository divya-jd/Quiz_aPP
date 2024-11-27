import 'dart:async';
import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/api_service.dart';

class QuizScreen extends StatefulWidget {
  final Map<String, dynamic> settings;
  QuizScreen({required this.settings});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _loading = true;
  bool _answered = false;
  String _feedbackText = "";
  late Timer _timer;
  int _timeLeft = 15;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timeLeft = 15;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          _submitAnswer(null); // Mark question as incorrect if time's up
        }
      });
    });
  }

  Future<void> _loadQuestions() async {
    try {
      final questions = await ApiService.fetchQuestions(
        int.parse(widget.settings['numQuestions']),
        int.parse(widget.settings['category']),
        widget.settings['difficulty'],
        widget.settings['type'],
      );
      setState(() {
        _questions = questions;
        _loading = false;
      });
      _startTimer();
    } catch (e) {
      print(e);
    }
  }

  void _submitAnswer(String? selectedAnswer) {
    setState(() {
      _answered = true;
      final correctAnswer = _questions[_currentQuestionIndex].correctAnswer;
      if (selectedAnswer == correctAnswer) {
        _score++;
        _feedbackText = "Correct! The answer is $correctAnswer.";
      } else {
        _feedbackText = "Incorrect. The correct answer is $correctAnswer.";
      }
    });
    _timer.cancel();
  }

  void _nextQuestion() {
    setState(() {
      _answered = false;
      _feedbackText = "";
      _currentQuestionIndex++;
      if (_currentQuestionIndex < _questions.length) {
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_currentQuestionIndex >= _questions.length) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Quiz Finished! Your Score: $_score/${_questions.length}'),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Back to Setup'),
              ),
            ],
          ),
        ),
      );
    }

    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: (_currentQuestionIndex + 1) / _questions.length,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Time Left: $_timeLeft seconds', style: TextStyle(fontSize: 16)),
            Text(
              'Question ${_currentQuestionIndex + 1}/${_questions.length}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(question.question, style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ...question.options.map((option) {
              return ElevatedButton(
                onPressed: _answered ? null : () => _submitAnswer(option),
                child: Text(option),
              );
            }),
            if (_answered)
              Column(
                children: [
                  Text(
                    _feedbackText,
                    style: TextStyle(
                      fontSize: 16,
                      color: _feedbackText.contains("Correct!") ? Colors.green : Colors.red,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text('Next Question'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
