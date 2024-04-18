import 'package:cubit_1/cubit/todo_cubit.dart';
import 'package:cubit_1/cubit/todo_state.dart';
import 'package:cubit_1/screeens/second_page.dart';
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
    //// cubit
    context.read<TodoCubit>().getInitialTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TodoCubit, TodoDBState>(
        builder: (_, state) {
          if (state is LoadingState) {
            return const Center(
                child: CircularProgressIndicator(),
            );
          } else if (state is FailureState) {
            return Center(
                child: Text('Error : ${state.errorMsg}'),
            );
          } else if (state is SuccessfulState) {
            var myData = state.allTodoStates;
            return ListView.builder(
              itemCount: myData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage(isUpdate: true,updateTodoModel: myData[index])));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text('${index + 1}',style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(myData[index].title),
                    subtitle: Text(myData[index].desc),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<TodoCubit>().deleteNote(id: myData[index].id);
                        }),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SecondPage()));
        },
        child: const Text('Next'),
      ),
    );
  }
}
