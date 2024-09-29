import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskItemData {
  String title;
  String subtitle;
  bool isChecked;
  DateTime? selectedDate; // Add selectedDate field

  TaskItemData({
    required this.title,
    required this.subtitle,
    required this.isChecked,
    this.selectedDate,
  });
}

class TaskItem extends StatefulWidget {
  final String title;
  final String subtitle;
  late bool isChecked;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onDelete;
  final Function(DateTime?) onDateSelected; // Add callback for date selection

  TaskItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onChanged,
    required this.onDelete,
    required this.onDateSelected, // Initialize onDateSelected
  });

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  DateTime? _selectedDate;

  // Function to pick a date using showDatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
      widget.onDateSelected(_selectedDate); // Call the date selected callback
    }
  }

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
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              if (_selectedDate != null) // Display selected date if available
                Text(
                  DateFormat('MMMM dd, yyyy').format(_selectedDate!),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 152, 152, 152),
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
            icon: const Icon(Icons.date_range,
                color: Color.fromARGB(255, 69, 69, 69)),
            onPressed: () {
              _selectDate(context); // Open date picker
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline,
                color: Color.fromARGB(255, 69, 69, 69)),
            onPressed: widget.onDelete, // Call the delete function
          ),
        ],
      ),
    );
  }
}
