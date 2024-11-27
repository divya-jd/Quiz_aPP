import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class ApiService {
  static Future<List<Question>> fetchQuestions(
    int numQuestions,
    int category,
    String difficulty,
    String type,
  ) async {
    final url = Uri.parse(
        'https://opentdb.com/api.php?amount=$numQuestions&category=$category&difficulty=$difficulty&type=$type');
    
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['response_code'] == 0) {
        return (data['results'] as List)
            .map((json) => Question.fromJson(json))
            .toList();
      } else {
        throw Exception('No questions available for the selected settings.');
      }
    } else {
      throw Exception('Failed to fetch questions.');
    }
  }
}
