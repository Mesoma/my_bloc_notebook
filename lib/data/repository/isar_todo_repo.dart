import 'package:isar/isar.dart';
import 'package:my_bloc_notebook/data/models/isar_todo_database.dart';
import '../../domain/models/default_todo_model.dart';
import '../../domain/repository/default_todo_repo.dart';


//create a class to implement the to_do repo from the domain layer
class IsarTodoRepo implements TodoRepo{

  //create a variable of type Isar
  final Isar db;
  IsarTodoRepo(this.db);

  //to get to_do list from the database(db) and store it when the function is called as a {List of Todos}
  @override
  Future<List<Todo>> loadTodos() async {
    final todos = await db.todoIsars.where().findAll();
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  //add a to_do to the database
  @override
  Future<void> addTodo(Todo newTodo) {
    //convert to an isar to_do object
    final todoIsar = TodoIsar.fromDomain(newTodo);

    //store in database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }


  //update to_do
  @override
  Future<void> updateTodo(Todo todo) {
    //convert to an isar to_do object
    final todoIsar = TodoIsar.fromDomain(todo);

    //store in database
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  //delete to_do
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }

}