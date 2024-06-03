import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/todo_controllers.dart';
import '../services/todo_http_services.dart';
import 'drawer.dart';
import 'widgets/add_todo.dart';
import 'widgets/edit_todo.dart';
import 'widgets/todo_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TodoControllers todoControllers = TodoControllers();
  final todoHttpServices = TodoHttpServices();

  @override
  Widget build(BuildContext context) {
    Map exercise = todoControllers.todoChecks();
    return Scaffold(
      drawer: Drawers(),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          'Todo App',
          style: GoogleFonts.poppins(
              textStyle: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Map<String, dynamic>? data = await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) {
              return AddTodo();
            },
          );

          if (data?['name'] != null) {
            if (data!['date'] != '') {
              todoControllers.add(data['name'], data['date'], false);
            } else {
              todoControllers.add(
                  data['name'], DateTime.now().toString().split(' ')[0], false);
            }
          }
          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(30),
          Center(
            child: Container(
              width: 370,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bajarilgan: ${exercise['bajarilgan']}',
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  Text(
                    'Bajarilmagan: ${exercise['bajarilmagan']}',
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 600,
            child: FutureBuilder(
                future: todoControllers.list,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text('Todo mavjud emas, iltimos todo qoshing '),
                    );
                  }
                  final todos = snapshot.data;
                  return todos == null || todos.isEmpty
                      ? const Center(
                          child:
                              Text('Todo mavjud emas, iltimos todo qoshing '),
                        )
                      : ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (ctx, index) {
                            return TodoWidget(
                              todoModels: todos[index],
                              onDelete: () {
                                todoControllers.delete(todos[index].id);
                                setState(() {});
                              },
                              onEdit: () async {
                                Map<String, dynamic>? data = await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) {
                                    return EditTodo(
                                      index: index,
                                    );
                                  },
                                );
                                if (data?['date'].isEmpty) {
                                  todoControllers.edit(
                                    todos[index].id,
                                    data!['name'],
                                    DateTime.now().toString().split(' ')[0],
                                  );
                                  // todoControllers.edit('', name, date, index)
                                } else {
                                  todoControllers.edit(todos[index].id,
                                      data!['name'], data['date']);
                                }
                                setState(() {});
                              },
                              onPress: () {
                                setState(() {});
                              },
                              onTapp: () {
                                todoHttpServices.isDoneTodos(todos[index].id);
                                // todos[index].isDone = !todos[index].isDone;
                                setState(() {});
                              },
                              id: index,
                            );
                          });
                }),
          ),
        ],
      ),
    );
  }
}
