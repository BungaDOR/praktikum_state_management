import 'package:flutter/foundation.dart';
import 'dart:collection';

class TaskData extends ChangeNotifier {
  // Data Private
  final List<String> _tasks = [];

  // Getter (agar data tidak bisa diubah langsung dari luar tanpa fungsi add)
  UnmodifiableListView<String> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;

  void addTask(String newTask) {
    _tasks.add(newTask);
    // Memberitahu semua widget yang mendengarkan (Listeners) untuk rebuild
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
