import '../models/todo_model_cubit.dart';

abstract class TodoDBState{}

class InitialState extends TodoDBState{}

class LoadingState extends TodoDBState{}

class SuccessfulState extends TodoDBState{
  List<TodoModel> allTodoStates;
  SuccessfulState({required this.allTodoStates});
}

class FailerState extends TodoDBState{
  String errorMsg;
  FailerState({required this.errorMsg});
}