import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maidstest/Model/todoModel.dart';

class Updatataskapi {
  Future<Map<String, dynamic>> updatetask(int taskId, bool completed) async {
    final response = await http.put(
      Uri.parse('https://dummyjson.com/todos/$taskId'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'completed': completed,
      }),
    );
    return {
      'statusCode': response.statusCode,
      'data': Todo.fromJson(jsonDecode(response.body)),
    };
  }
}
