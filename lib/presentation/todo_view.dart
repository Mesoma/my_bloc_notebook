import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_notebook/presentation/todo_cubit.dart';
import '../domain/models/default_todo_model.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  //showing box for user to type
  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(controller: textController),
        actions: [

          //add button
          TextButton(
              onPressed: (){
                todoCubit.addTodo(textController.text);
                Navigator.of(context).pop();},
              child: const Text("Add")
          ),

          const SizedBox(width: 85, height: 1,),

          //cancel button
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel")
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final todoCubit = context.read<TodoCubit>();


    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white70,
          child: Column(
            children: [
              const DrawerHeader(child: Icon(Icons.notes_outlined, size: 48)),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.add_box_rounded),
                title: const Text("ADD NEW TASK"),
                onTap: () {
                  Navigator.pop(context);
                  _showAddTodoBox(context);
                }
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: const Icon(Icons.notes),
          centerTitle: true,
          backgroundColor: Colors.blue[300],
        ),
        backgroundColor: Colors.blue[100],
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[300],
          onPressed: () => _showAddTodoBox(context),
          child: const Icon(Icons.add, color: Colors.black87,),
        ),

        body: BlocBuilder<TodoCubit, List<Todo>>(
          builder: (context, todos) {
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];

                return Padding(
                  padding: const EdgeInsets.only(top: 15, left: 8.0, right: 8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: ListTile(

                          //text
                          title: Text(todo.text),

                          //check box
                          leading: Checkbox(
                            checkColor: Colors.white,
                            value: todo.isCompleted,
                            onChanged: (value) => todoCubit.toggleCompletion(todo),
                          ),

                          //delete button
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => todoCubit.deleteTodo(todo),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        )
    );
  }
}
