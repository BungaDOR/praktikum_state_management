import 'package:flutter/foundation.dart';
import 'dart:collection';

// Model task
class Task {
  String name;
  bool isDone;

  Task({required this.name, this.isDone = false});
}

class TaskData extends ChangeNotifier {
  // Data Private
  final List<Task> _tasks = [];

  // Getter (agar data tidak bisa diubah langsung dari luar tanpa fungsi add)
  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;

  void addTask(String newTask) {
    _tasks.add(Task(name: newTask));
    // Memberitahu semua widget yang mendengarkan (Listeners) untuk rebuild
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index].isDone = !_tasks[index].isDone;
    notifyListeners();
  }
}
