import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:maidstest/API%20service/AddTaskApi.dart';
import 'package:maidstest/API%20service/deleteTask.dart';
import 'package:maidstest/Model/UserModel.dart';
import 'package:maidstest/Model/todoModel.dart';
import 'package:maidstest/API%20service/taskApi.dart';
import 'package:maidstest/const/Tcolor.dart';
import 'package:maidstest/widget/Mysnack.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  int skip = 0;
  int limit = 10;
  int total = 0;
  int taskid = 255;
  List<Todo> todos = [];
  User? user;
  final Taskapi taskapi = Taskapi();
  bool isChecked = false;
  bool isLoading = false;

  String title = '';
  TaskProvider() {
    getUsre().then((_) => getTask());
  }

  Future<void> getUsre() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userData = prefs.getString('user');
    if (userData != null) {
      user = User.fromJson(jsonDecode(userData));
    } else {
      user = null;
    }
  }

  Future<void> getTask() async {
    if (user == null) return;
    isLoading = true;
    notifyListeners();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? todosData = prefs.getString('todos');
      final int? totalTasks = prefs.getInt('total');

      if (todosData != null && totalTasks != null && totalTasks > 0) {
        List<Todo> storedTodos = (jsonDecode(todosData) as List)
            .map((data) => Todo.fromJson(data))
            .toList();
        total = totalTasks;

        if (skip + limit <= storedTodos.length) {
          todos = storedTodos.sublist(0, skip + limit);
        } else {
          todos = storedTodos;
        }
      } else {
        final task = await taskapi.getTask(user!.id, limit, skip);
        todos = task.todos;
        total = task.total;

        prefs.setString(
            'todos', jsonEncode(todos.map((todo) => todo.toJson()).toList()));
        prefs.setInt('total', total);
      }

      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreTasks() async {
    if (todos.length < total) {
      limit += 5;
      await getTask();
    }
  }

  Future<void> AddTask(context) async {
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    final Addtaskapi addtaskapi = Addtaskapi();

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await addtaskapi.addTask(user!.id, title, isChecked);
      int statusCode = response['statusCode'];
      Todo newtask = response['data'];
      if (statusCode == 201) {
        newtask.id = taskid + 1;
        taskid++;
        print(newtask.id);
        todos = todos + [newtask];
        total++;
        prefs.setString(
            'todos', jsonEncode(todos.map((todo) => todo.toJson()).toList()));
        prefs.setInt('total', total);
        notifyListeners();
        Loader.hide();
        resetdata();
        Navigator.of(context).pop();
        final snackbar = AnimatedSnackBar(
          mobileSnackBarPosition: MobileSnackBarPosition.bottom,
          duration: Duration(seconds: 5),
          builder: ((context) {
            return MySnackbar(
              title: 'task has been Aded successfully',
              color: Tcolor.Seccolor,
            );
          }),
        );
        snackbar.show(context);
        snackbar.remove();
      }
    } catch (e) {
      print('eror');
      print(e);
    }
  }

  Future<void> update(BuildContext context, int taskId, bool completed) async {
    Loader.show(context, progressIndicator: CircularProgressIndicator());

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      int index = todos.indexWhere((todo) => todo.id == taskId);
      todos[index].completed = completed;

      prefs.setString(
          'todos', jsonEncode(todos.map((todo) => todo.toJson()).toList()));
      final snackbar = AnimatedSnackBar(
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        duration: Duration(seconds: 5),
        builder: ((context) {
          return MySnackbar(
            title: 'task has been Updated successfully',
            color: Tcolor.Seccolor,
          );
        }),
      );
      snackbar.show(context);
      snackbar.remove();
    } catch (e) {
    } finally {
      Loader.hide();
      notifyListeners();
    }
  }

  Future<void> deleteTask(BuildContext context, int taskId) async {
    Loader.show(context, progressIndicator: CircularProgressIndicator());
    final Deletetask deletetask = Deletetask();
    print(taskId);

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      int statusCode = await deletetask.delete(taskId);
      print(statusCode);
      todos.removeWhere((todo) => todo.id == taskId);
      total--;
      prefs.setString(
          'todos', jsonEncode(todos.map((todo) => todo.toJson()).toList()));
      prefs.setInt('total', total);
      final snackbar = AnimatedSnackBar(
        mobileSnackBarPosition: MobileSnackBarPosition.bottom,
        duration: Duration(seconds: 5),
        builder: ((context) {
          return MySnackbar(
            title: 'task has been Deleted successfully',
            color: const Color.fromARGB(255, 109, 9, 2),
          );
        }),
      );
      snackbar.show(context);
      snackbar.remove();
    } catch (e) {
      print('error');
      print(e);
    } finally {
      Loader.hide();
      notifyListeners();
    }
  }

  void resetdata() {
    title = '';
    isChecked = false;
  }
}
