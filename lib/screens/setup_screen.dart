import 'package:flutter/material.dart';
import 'quiz_screen.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  final TextEditingController _numQuestionsController = TextEditingController();
  String selectedCategory = '9'; // Default: General Knowledge
  String selectedDifficulty = 'easy'; // Default difficulty
  String selectedType = 'multiple'; // Default type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _numQuestionsController,
              decoration: InputDecoration(
                labelText: 'Number of Questions',
                hintText: 'Enter a number (e.g., 5, 10, 15)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: selectedCategory,
              items: [
                DropdownMenuItem(value: '9', child: Text('General Knowledge')),
                DropdownMenuItem(value: '21', child: Text('Sports')),
                DropdownMenuItem(value: '23', child: Text('History')),
                // Add more categories here
              ],
              onChanged: (value) {
                setState(() {
                  selectedCategory = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Select Category'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: selectedDifficulty,
              items: [
                DropdownMenuItem(value: 'easy', child: Text('Easy')),
                DropdownMenuItem(value: 'medium', child: Text('Medium')),
                DropdownMenuItem(value: 'hard', child: Text('Hard')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedDifficulty = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Select Difficulty'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField(
              value: selectedType,
              items: [
                DropdownMenuItem(value: 'multiple', child: Text('Multiple Choice')),
                DropdownMenuItem(value: 'boolean', child: Text('True/False')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedType = value.toString();
                });
              },
              decoration: InputDecoration(labelText: 'Select Question Type'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      settings: {
                        'numQuestions': _numQuestionsController.text,
                        'category': selectedCategory,
                        'difficulty': selectedDifficulty,
                        'type': selectedType,
                      },
                    ),
                  ),
                );
              },
              child: Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
