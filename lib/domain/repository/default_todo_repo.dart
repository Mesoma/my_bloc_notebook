// this repo defines what can happen to a to_do object in the app, basically what can the user do.

import 'package:my_bloc_notebook/domain/models/default_todo_model.dart';


// we use an abstract class cause this will be fundamental functions and wont have instances created from them
// the abstract class just tells the app what it can do
 abstract class TodoRepo {

  //load to_do tiles
  Future<List<Todo>> loadTodos();

  //add a to_do
  Future<void> addTodo(Todo newTodo);

  //delete a to_do
  Future<void> deleteTodo(Todo todo);

  //update to_do list
  Future<void> updateTodo(Todo todo);

}