import '../db/db_connection.dart';
import '../models/todo_model_cubit.dart';

class TodoCubitState {
  DbAppConnection? cubitDatabase;
  
  
  List<TodoCubitModel> todoModel = [];

  TodoCubitState({required this.todoModel});
  
  List<TodoCubitModel> _listTodos = [];

  List<TodoCubitModel> fetchTodos(){
    return _listTodos;
  }

  //// add
  void addTodoCubit({required TodoCubitModel todoCubitModel}) async {
    cubitDatabase?.addTodos(todoCubitModel: todoCubitModel);
    _listTodos = await cubitDatabase.getAllTodoList();
  }
}
