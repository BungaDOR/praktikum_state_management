import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'task_data.dart'; // Import model
import 'task_screen.dart'; // Kita akan buat ini setelahnya

void main() {
  runApp(
    // Membungkus Root App agar Provider tersedia di seluruh aplikasi
    ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Provider Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const TaskScreen(), // Halaman utama kita ganti
    );
  }
}

