import 'package:cubit_1/cubit/todo_cubit.dart';
import 'package:cubit_1/models/todo_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .09),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  labelText: 'Enter title', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: descController,
              decoration: const InputDecoration(
                  labelText: 'Enter Desc', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {
                  context.read<TodoCubit>().addNote(
                      newTodoModel: TodoModel(title: titleController.text, desc: descController.text)
                  );
                  Navigator.pop(context);
                }, child: const Text('Add')),

                ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text('Cancel')),
              ],
            ),

            
          ],
        ),
      ),
    );
  }
}
