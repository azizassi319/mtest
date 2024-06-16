import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maidstest/Model/todoModel.dart';

class Addtaskapi {
  static const String loginUrl = 'https://dummyjson.com/todos/add';

  Future<Map<String, dynamic>> addTask(
      int userId, String title, bool completed) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'todo': title,
        'completed': completed,
        'userId': userId,
      }),
    );
    return {
      'statusCode': response.statusCode,
      'data': Todo.fromJson(jsonDecode(response.body)),
    };
  }
}
