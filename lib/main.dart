import 'package:cubit_1/cubit/todo_cubit.dart';
import 'package:cubit_1/db/db_connection.dart';
import 'package:cubit_1/screeens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => TodoCubit(db: DbAppConnection.db),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cubit App',
      home: HomePage(),
    );
  }
}
