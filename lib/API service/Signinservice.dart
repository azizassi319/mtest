import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maidstest/Model/UserModel.dart';

class SigninApiService {
  static const String loginUrl = 'https://dummyjson.com/auth/login';

  Future<User> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );
    print(response.statusCode);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else if (response.statusCode == 400) {
      throw ('Incorrect username or password');
    } else {
      throw ('Failed to login');
    }
  }
}
