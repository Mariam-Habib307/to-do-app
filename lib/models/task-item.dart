import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  final String title;
  final String subtitle;
  late bool isChecked;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete; // New callback for delete functionality

  TaskItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onChanged,
    required this.onDelete, // Initialize onDelete
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 6,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                widget.subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const Spacer(),
          Checkbox(
            value: widget.isChecked,
            onChanged: widget.onChanged,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                color: Color.fromARGB(255, 25, 2, 0)),
            onPressed: widget.onDelete, // Call the delete function
          ),
        ],
      ),
    );
  }
}
