// We use Isar for database
// So we get our to_dos and store them in an Isar component using the methods, and we can also retrieve it later


import 'package:isar/isar.dart';
import '../../domain/models/default_todo_model.dart';

//to generate isar_todo_database.g.dart run: dart run build_runner build in command line
//this is to complete the Isar setup
part 'isar_todo_database.g.dart';

@collection
//Isar Class to mirror our to_do object
class TodoIsar {
  Id id = Isar.autoIncrement; //Isar will handle Ids
  late String text;           //we use "late" String and bool to show that these variables will be initialized later in the life of our app
  late bool isCompleted;

  //method to convert isar object to pure to_do object
  Todo toDomain(){
    return Todo(
        id: id,
        text: text,
        isCompleted: isCompleted
    );
  }

  //method to convert pure to_do object to an isar object
  static TodoIsar fromDomain(Todo todo){
    return TodoIsar()
      ..id = todo.id
      ..text = todo.text
      ..isCompleted = todo.isCompleted;
  }


  //you can put this code as the fromDomain function if you don't want to use the cascade(..) way

  // static TodoIsar fromDomain(Todo todo){
  // TodoIsar todoIsar = TodoIsar();  // Create a new TodoIsar object
  // todoIsar.id = todo.id;           // Set the id
  // todoIsar.text = todo.text;       // Set the text
  // todoIsar.isCompleted = todo.isCompleted; // Set the isCompleted status
  //
  // return todoIsar;
  //}
}