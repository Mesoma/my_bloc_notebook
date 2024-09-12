import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/models/default_todo_model.dart';
import '../domain/repository/default_todo_repo.dart';



//The cubit in the presentation layer handles Bloc state management
//This class "TodoCubit" is responsible for managing the state of a list of to_do objects


// everytime you extend a cubit, you have to specify which "Type"
// this informs the system of what Type of state you want to Manage (int, String, List e.t.c)
class TodoCubit extends Cubit<List<Todo>>{


  //creating a variable from the abstract class TodoRepo in the domain layer
  //this means that the variable "todoRepo" can now access all the properties and methods of the abstract class "TodoRepo"
  final TodoRepo todoRepo;


  // super([]): is the part of the constructor calls the superclass constructor (Cubit<List<Todo>>) with an initial state of an empty list ([]).
  // This means that when the TodoCubit is first created, the initial state is an empty list of Todo items.
  TodoCubit(this.todoRepo) : super ([]) {
    loadTodos();
  }

  //load to_do
  Future<void> loadTodos() async{
    final todoList = await todoRepo.loadTodos();

    //emit fetched list as new state
    emit(todoList);
  }

  //add new to_do
  Future<void> addTodo (String text) async {

    //adding a new to_do
    final newTodo = Todo(

      //DateTime.now() to get a random id.
        id: DateTime.now().microsecondsSinceEpoch,
        text: text
    );

    //putting it in repo
    await todoRepo.addTodo(newTodo);

    //reload
    loadTodos();
  }


  //delete to_do
  Future<void> deleteTodo(Todo todo) async {

    //delete to_do
    await todoRepo.deleteTodo(todo);

    //reload
    loadTodos();
  }


  //toggle
  Future<void> toggleCompletion(Todo todo) async {

    // toggle completion, note that logic is in domain layer
    final updatedTodo = todo.toggleCompletion();

    //update repository with to_do with new completion status
    await todoRepo.updateTodo(updatedTodo);

    //reload
    loadTodos();
  }
}