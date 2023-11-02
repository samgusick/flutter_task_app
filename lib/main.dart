import 'package:flutter/material.dart';
import 'actionButton.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{

  final myController = TextEditingController();
  List<String> tasks = [];
  List<bool> taskChecked = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),

        body: Column(
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    addTask();
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return
                  Dismissible(
                      child: ListTile(
                    title: Text(tasks[index]),
                    trailing: IconButton(
                      icon: taskChecked[index]
                          ? Icon(Icons.check_box)
                          : Icon(Icons.check_box_outline_blank),
                      onPressed: () {
                        setState(() {
                          // Toggle the checked state for the task at the given index
                          taskChecked[index] = !taskChecked[index];
                        });
                      },
                    ),
                      ),
                    key: ValueKey(index),
                      onDismissed: (direction) {
                        setState(() {
                          tasks.removeAt(index);
                          taskChecked.removeAt(index);
                        });
                      }
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.clear();
                  taskChecked.clear();
                });
              },
              child: Text("Clear"),
            )
        ]
      ),
    )
    );
  }

  void addTask() {
    String task = myController.text.trim();
    if (task.isNotEmpty) {
      setState(() {
        tasks.add(task);
        taskChecked.add(false);
        myController.clear();
      });
    }
  }


}
