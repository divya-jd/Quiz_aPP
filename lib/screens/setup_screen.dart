import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _numQuestions = 5;
  String _selectedCategory = "9"; // Default: General Knowledge
  String _selectedDifficulty = "easy";
  String _selectedType = "multiple";

  final List<String> _difficultyLevels = ['easy', 'medium', 'hard'];
  final List<String> _questionTypes = ['multiple', 'boolean'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz Setup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Customize your Quiz',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Number of Questions
            DropdownButtonFormField<int>(
              value: _numQuestions,
              decoration: InputDecoration(labelText: 'Number of Questions'),
              items: [5, 10, 15]
                  .map((value) => DropdownMenuItem(value: value, child: Text('$value')))
                  .toList(),
              onChanged: (value) {
                setState(() => _numQuestions = value!);
              },
            ),
            SizedBox(height: 16),
            // Category Selector
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: InputDecoration(labelText: 'Select Category'),
              items: [
                DropdownMenuItem(value: "9", child: Text('General Knowledge')),
                DropdownMenuItem(value: "11", child: Text('Movies')),
                DropdownMenuItem(value: "21", child: Text('Sports')),
              ],
              onChanged: (value) {
                setState(() => _selectedCategory = value!);
              },
            ),
            SizedBox(height: 16),
            // Difficulty Level Selector
            DropdownButtonFormField<String>(
              value: _selectedDifficulty,
              decoration: InputDecoration(labelText: 'Select Difficulty'),
              items: _difficultyLevels
                  .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedDifficulty = value!);
              },
            ),
            SizedBox(height: 16),
            // Question Type Selector
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(labelText: 'Select Type'),
              items: _questionTypes
                  .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedType = value!);
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/quiz',
                  arguments: {
                    'numQuestions': _numQuestions,
                    'category': _selectedCategory,
                    'difficulty': _selectedDifficulty,
                    'type': _selectedType,
                  },
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
