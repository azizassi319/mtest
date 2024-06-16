import 'package:flutter/material.dart';
import 'package:maidstest/Provider/Taskprovider.dart';
import 'package:maidstest/const/Tcolor.dart';
import 'package:maidstest/widget/My_Button.dart';
import 'package:maidstest/widget/TextFlldBilder.dart';
import 'package:maidstest/widget/sizedboxbilder.dart';
import 'package:maidstest/widget/todoItem.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TodosPage extends StatefulWidget {
  static const screenRoute = '/task';

  @override
  State<TodosPage> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Tcolor.maincolor,
          centerTitle: true,
          title: Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return Text(
                  'Hello ${taskProvider.user?.firstName ?? ''} ${taskProvider.user?.lastName ?? ''} ',
                  style: Theme.of(context).textTheme.titleLarge);
            },
          ),
        ),
        floatingActionButton: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
            return FloatingActionButton(
              child: Icon(Icons.add, color: Tcolor.white),
              backgroundColor: Tcolor.maincolor,
              onPressed: () {
                Alert(
                  style: AlertStyle(
                    isOverlayTapDismiss: false,
                    alertBorder: Border.all(color: Tcolor.maincolor),
                  ),
                  context: context,
                  title: 'Add Task',
                  content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),
                              Text('Task Title: '),
                              SizedBox(height: 10),
                              TextFieldBilder(
                                Title: 'Title',
                                onchange: (value) {
                                  taskProvider.title = value;
                                },
                                obscureText: false,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Task Completed'),
                                  Checkbox(
                                    checkColor: Tcolor.white,
                                    activeColor: Tcolor.maincolor,
                                    value: taskProvider.isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        taskProvider.isChecked = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  buttons: [
                    DialogButton(
                      color: Tcolor.maincolor,
                      onPressed: () async {
                        if (taskProvider.title.isNotEmpty) {
                          await taskProvider.AddTask(context);
                        } else {
                          Alert(
                            style: AlertStyle(
                              isOverlayTapDismiss: false,
                              alertBorder: Border.all(color: Tcolor.maincolor),
                            ),
                            context: context,
                            title: 'Sory',
                            content: Text('Please Enter Task Title'),
                            buttons: [
                              DialogButton(
                                color: Tcolor.maincolor,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'ok',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ],
                          ).show();
                        }
                      },
                      child: Text(
                        'ADD',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ).show();
              },
            );
          },
        ),
        body: Consumer<TaskProvider>(builder: (context, taskProvider, child) {
          if (taskProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (taskProvider.todos.isEmpty) {
            return Center(child: Text('No data'));
          } else {
            return ListView(
              children: [
                sizedboxbilder(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('You have ',
                        style: Theme.of(context).textTheme.displaySmall),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Tcolor.maincolor),
                        padding: EdgeInsets.all(5),
                        child: Center(
                          child: Text('${taskProvider.total}',
                              style: Theme.of(context).textTheme.displayMedium),
                        ),
                      ),
                    ),
                    Text('tasks to do ',
                        style: Theme.of(context).textTheme.displaySmall),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: taskProvider.todos.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = taskProvider.todos.length - 1 - index;
                    return Todoitem(task: taskProvider.todos[reversedIndex]);
                  },
                ),
                if (taskProvider.todos.length < taskProvider.total)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: My_button(
                        color: Tcolor.white,
                        title: 'Load More',
                        titleColor: Tcolor.maincolor,
                        onpressed: () {
                          taskProvider.loadMoreTasks();
                        }),
                  )
              ],
            );
          }
        }),
      ),
    );
  }
}
