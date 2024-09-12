

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bloc_notebook/presentation/todo_cubit.dart';
import 'package:my_bloc_notebook/presentation/todo_view.dart';

import '../domain/repository/default_todo_repo.dart';


//Home Page of our App

//connects our cubit(TodoCubit) to the UI(TodoView())

class TodoPage extends StatelessWidget {
  final TodoRepo todoRepo2;

  const TodoPage({super.key, required this.todoRepo2});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(todoRepo2),
      child: const TodoView(),
    );
  }
}