import 'package:flutter/material.dart';
import 'package:maidstest/Model/todoModel.dart';
import 'package:maidstest/Provider/Taskprovider.dart';
import 'package:maidstest/const/Tcolor.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Todoitem extends StatelessWidget {
  final Todo task;

  const Todoitem({required this.task});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onLongPress: () {
          Alert(
            style: AlertStyle(
              isOverlayTapDismiss: false,
              alertBorder: Border.all(
                color: Tcolor.maincolor,
              ),
            ),
            context: context,
            title: 'Are You Sure?',
            content: Container(
              child: Text('Do you want to delete this task?'),
            ),
            buttons: [
              DialogButton(
                color: Tcolor.maincolor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              DialogButton(
                color: Tcolor.maincolor,
                onPressed: () {
                  final taskProvider =
                      Provider.of<TaskProvider>(context, listen: false);
                  taskProvider.deleteTask(context, task.id);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ).show();
          print('Alert shown');
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 9,
                  offset: Offset(0, 1),
                ),
              ],
              color: Tcolor.maincolor,
              border: Border.all(
                color: Tcolor.appBarColor,
              ),
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: Text(task.todo,
                      style: Theme.of(context).textTheme.displayMedium)),
              Consumer<TaskProvider>(builder: (context, taskProvider, child) {
                return Checkbox(
                  checkColor: Tcolor.white,
                  activeColor: Colors.green,
                  value: task.completed,
                  onChanged: (value) {
                    task.completed = value as bool;
                    print(task.completed);
                    print(value);
                    taskProvider.update(context, task.id, value as bool);
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
