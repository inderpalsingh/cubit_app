import 'package:cubit_1/cubit/todo_state.dart';
import 'package:cubit_1/db/db_connection.dart';
import 'package:cubit_1/models/todo_model_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<TodoDBState> {

  DbAppConnection db;

  TodoCubit({required this.db}) : super(InitialState());


   ///// events
  
   void getInitialTodos()async{

    emit(LoadingState());
    List<TodoModel> mData =  await db.getAllTodoList();
    emit(SuccessfulState(allTodoStates: mData));
    
   }



   void addNote({required TodoModel newTodoModel}) async {

    emit(LoadingState());
    
    //bool isTodoAdded =  await db.addTodo(todoModel: newTodoModel);
    int isTodoAdded =  await db.addTodo(todoModel: newTodoModel);

    if(isTodoAdded>0){

      List<TodoModel> allTodos = await db.getAllTodoList();
      emit(SuccessfulState(allTodoStates: allTodos));
    }else{
      emit(FailerState(errorMsg: "Todo not addedd"));
    }


   }


}
