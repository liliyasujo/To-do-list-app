import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/adapters/todo_adapter.dart';
import 'package:task_manager/views/add_todo.dart';

class TodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[700],
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddTodo()),
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title:
            Text("Today's Tasks", style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Todo>('todos').listenable(),
        builder: (context, Box<Todo> box, _) {
          if (box.values.isEmpty) {
            return Center(
              child: Text("No Tasks to Do !!",
                  style: TextStyle(fontFamily: 'Montserrat')),
            );
          }
          return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Todo? todo = box.getAt(index);
                return ListTile(
                  leading: Icon(Icons.calendar_today_outlined),
                  onLongPress: () async {
                    await box.deleteAt(index);
                  },
                  title: Text(
                    todo!.title,
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  ),
                  subtitle: Text(
                    todo.description,
                    style: TextStyle(fontSize: 16, fontFamily: 'Montserrat'),
                  ),
                  
                );
              });
        },
      ),
    );
  }
}