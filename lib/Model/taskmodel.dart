import 'package:maidstest/Model/todoModel.dart';

class Task {
  final List<Todo> todos;
  final int total;
  final int skip;
  final int limit;

  Task({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    var todosJson = json['todos'] as List;
    List<Todo> todosList = todosJson.map((i) => Todo.fromJson(i)).toList();

    return Task(
      todos: todosList,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'todos': todos.map((todo) => todo.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,
    };
  }
}
