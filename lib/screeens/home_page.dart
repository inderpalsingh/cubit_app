import 'package:cubit_1/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<TodoCubit>().getInitialTodos();


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('ddd'),
    );
  }
}
