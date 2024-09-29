import 'package:flutter/material.dart';
import 'package:to_do_app/models/task-item.dart';
import 'package:intl/intl.dart';
import 'add_task_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<TaskItemData> tasks = [
    TaskItemData(
        title: 'READING BOOKS', subtitle: 'Read every day', isChecked: true),
    TaskItemData(
        title: 'PAINTING', subtitle: 'Half an hour a day', isChecked: true),
    TaskItemData(
        title: 'SAVE MONEY', subtitle: 'Five dollars a day', isChecked: false),
    TaskItemData(
        title: 'CLIMB MOUNTAINS',
        subtitle: 'Three hours today',
        isChecked: false),
  ];

  void _addNewTask(String title, String subtitle) {
    setState(() {
      tasks.add(
          TaskItemData(title: title, subtitle: subtitle, isChecked: false));
    });
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index); // Remove the task at the specified index
    });
  }
  TextEditingController dateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3150B8),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  '2019',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Text(
              'April 8th',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskItem(
                    title: task.title,
                    subtitle: task.subtitle,
                    isChecked: task.isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        tasks[index].isChecked = value!;
                      });
                    },
                    onDelete: () {
                      _deleteTask(index); // Delete the task at this index
                    },
                  );
                },
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(
                      addTaskCallback: _addNewTask,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItemData {
  String title;
  String subtitle;
  bool isChecked;

  TaskItemData({
    required this.title,
    required this.subtitle,
    required this.isChecked,
  });
}
