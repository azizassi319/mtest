import 'package:http/http.dart' as http;

class Deletetask {
  Future<int> delete(
    int taskId,
  ) async {
    final response = await http.delete(
      Uri.parse('https://dummyjson.com/todos/$taskId'),
    );
    return response.statusCode;
  }
}
