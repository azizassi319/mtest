import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maidstest/Model/taskmodel.dart';

class Taskapi {
  Future<Task> getTask(int userId, int limit, int skip) async {
    final response = await http.get(
      Uri.parse(
          'https://dummyjson.com/todos/user/$userId?limit=$limit&skip=$skip'),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Task.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('Invalid credentials');
    } else {
      throw Exception('Failed to login');
    }
  }
}
