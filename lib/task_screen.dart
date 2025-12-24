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
      ),
      body: Consumer<TaskData>(
        // Consumer hanya me-rebuild bagian ini saja saat data berubah
        builder: (context, taskData, child) {
          return ListView.builder(
            itemCount: taskData.taskCount,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(taskData.tasks[index]),
                trailing: IconButton(
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
        backgroundColor: Colors.green,
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
            style: TextStyle(fontSize: 24, color: Colors.green),
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
            child: const Text('Add'),
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
