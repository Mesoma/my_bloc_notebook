import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:my_bloc_notebook/presentation/todo_page.dart';
import 'package:path_provider/path_provider.dart';
import 'data/models/isar_todo_database.dart';
import 'data/repository/isar_todo_repo.dart';
import 'domain/repository/default_todo_repo.dart';



void main() async {
  //constant widget flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  //get directory path to use and store data
  final dir = await getApplicationDocumentsDirectory();

  //open Isar Database
  final isar = await Isar.open([TodoIsarSchema], directory: dir.path);

  //initialise repo with Isar database
  final isarTodoRepo = IsarTodoRepo(isar);

  //run App
  runApp(MyApp(todoRepo: isarTodoRepo));
}


class MyApp extends StatelessWidget {

  final TodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo2: todoRepo),
    );
  }
}
