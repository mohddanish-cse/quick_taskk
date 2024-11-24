class Task {
  String? id;
  String? taskText;
  bool isDone;
  DateTime? date;

  Task({
    this.id,
    this.taskText,
    this.isDone = false,
    this.date,
  });

  static List<Task> taskList() {
    return [
      // Task(
      //   id: '1',
      //   taskText: 'Task 1',
      //   isDone: true,
      //   date: DateTime.now(),
      // ),
      // Task(
      //   id: '2',
      //   taskText: 'Task 2',
      //   isDone: false,
      // ),
      // Task(
      //   id: '3',
      //   taskText: 'Task 3',
      //   isDone: false,
      // ),
      // Task(
      //   id: '4',
      //   taskText: 'Task 4',
      //   isDone: false,
      // ),
      // Task(
      //   id: '5',
      //   taskText: 'Task 5',
      //   isDone: false,
      // ),
    ];
  }
}
