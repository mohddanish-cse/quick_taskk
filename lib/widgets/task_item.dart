import 'package:flutter/material.dart';
import 'package:quick_taskk/models/task.dart';

import '../constants/colors.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  final void Function(Task)? onTaskChanged;
  final void Function(Task)? onDeleteItem;
  final void Function(Task)? onEditItem;

  const TaskItem({
    super.key,
    required this.task,
    this.onTaskChanged,
    this.onDeleteItem,
    this.onEditItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onTaskChanged!(task);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.taskText!,
                  style: TextStyle(
                    color: tdBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Due Date: ${task.date?.day}/${task.date?.month}/${task.date?.year}',
                  style: TextStyle(
                    color: tdBlack,
                    fontSize: 14,
                    decoration: task.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                onPressed: () => onEditItem!(task),
                icon: const Icon(
                  Icons.edit,
                ),
              ),
            ),
          ],
        ),
        trailing: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: tdRed,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            onPressed: () => onDeleteItem!(task),
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}
