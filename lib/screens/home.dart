import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/task.dart';
import '../constants/colors.dart';
import '../screens/login.dart';
import '../widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final taskList = Task.taskList();
  List<Task> _foundTask = [];
  final _taskController = TextEditingController();
  final _task1Controller = TextEditingController();
  final _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    _foundTask = taskList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        // All Tasks
                        Container(
                          margin: const EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            'All Tasks',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        // Tasks List
                        if (_foundTask.isEmpty)
                          const SizedBox(
                            height: 400,
                            child: Center(
                              child: Text(
                                'No tasks found',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        for (Task task in _foundTask.reversed)
                          TaskItem(
                            task: task,
                            onTaskChanged: _handleTaskTap,
                            onDeleteItem: _deleteTask,
                            onEditItem: _editTask,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // Add Task
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                          right: 20,
                          left: 20,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: _taskController,
                          decoration: const InputDecoration(
                            hintText: 'Add Task',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 10),
                      child: IconButton(
                          onPressed: _selectDate,
                          icon: const Icon(
                            Icons.calendar_month,
                            size: 30,
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, right: 20),
                      child: ElevatedButton(
                        onPressed: () => _addTask(
                          _taskController.text,
                          DateTime.parse(_dateController.text),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: tdBlue,
                          minimumSize: const Size(60, 60),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ));
  }

  void _editTask(Task task) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Edit Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _task1Controller,
                  decoration: const InputDecoration(
                    hintText: 'Task',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: _dateController,
                        decoration: const InputDecoration(
                          hintText: 'Date',
                        ),
                      ),
                    ),
                    dateButton(_selectDate),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  _updateTask(task);
                  setState(() {
                    _deleteTask(task);
                  });
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          );
        });
    setState(() {
      _task1Controller.text = task.taskText!;
      _dateController.text =
          '${task.date?.day}/${task.date?.month}/${task.date?.year}';
      selectedDate = task.date!;
    });
  }

  Widget dateButton(Function() onPressed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20, right: 10),
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.calendar_month,
          size: 30,
        ),
      ),
    );
  }

  void _updateTask(Task task) {
    setState(() {
      taskList.add(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        taskText: _task1Controller.text,
        date: selectedDate,
      ));
    });
    _taskController.clear();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            // '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
            pickedDate.toString();
        selectedDate = pickedDate;
      });
    }
  }

  void _runFilter(String enteredKeyword) {
    List<Task> results = [];
    if (enteredKeyword.isEmpty) {
      results = taskList;
    } else {
      results = taskList
          .where((task) => task.taskText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundTask = results;
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      taskList.remove(task);
    });
  }

  void _addTask(String task, DateTime date) {
    setState(() {
      taskList.add(Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        taskText: task,
        date: selectedDate,
      ));
    });
    _taskController.clear();
  }

  void _handleTaskTap(Task task) {
    setState(() {
      task.isDone = !task.isDone;
    });
  }

  Container searchBox() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              minWidth: 25,
              maxHeight: 20,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: tdGrey),
            border: InputBorder.none,
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: tdBGColor,
      title: const Text('QuickTask', style: TextStyle(color: tdBlack)),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            Get.offAll(() => const LoginPage());
          },
        ),
      ],
    );
  }
}
