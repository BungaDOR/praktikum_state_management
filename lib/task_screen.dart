import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_data.dart';

// Halaman Utama
class TaskScreen extends StatelessWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Mengakses data taskCount langsung dari Provider
        title: Text('Provider To-Do (${Provider.of<TaskData>(context).taskCount})'),
        backgroundColor: Colors.blue[200],
      ),
      body: Consumer<TaskData>(
        // Consumer hanya me-rebuild bagian ini saja saat data berubah
        builder: (context, taskData, child) {
          return ListView.builder(
            itemCount: taskData.taskCount,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Colors.green,
                checkColor: Colors.amber,
                title: Text(taskData.tasks[index].name,
                style: TextStyle(
                    decoration: taskData.tasks[index].isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                  ),
                ),
                value: taskData.tasks[index].isDone,
                onChanged: (value) {
                  taskData.toggleTask(index);
                },
                secondary: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Panggil fungsi di Provider
                    taskData.deleteTask(index);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
        onPressed: () {
          // Buka BottomSheet atau Halaman Baru
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTaskSheet(),
          );
        },
      ),
    );
  }
}

// Widget Input (Bisa dipisah ke file lain)
class AddTaskSheet extends StatelessWidget {
  const AddTaskSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String newTaskTitle = '';

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Tambah Tugas', 
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 5, 116, 131)),
          ),
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskTitle = newText;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(83, 0, 187, 212),
              foregroundColor: const Color.fromARGB(255, 2, 111, 125)
            ),
            child: const Text('Add',style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            onPressed: () {
              if (newTaskTitle.isNotEmpty) {
                // Menambahkan data via Provider
                Provider.of<TaskData>(context, listen: false).addTask(newTaskTitle);
                Navigator.pop(context); // Tutup modal
              }
            },
          ),
        ],
      ),
    );
  }
}
