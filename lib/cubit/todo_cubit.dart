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

    // int isTodoAdded =  await db.addTodo(todoModel: newTodoModel);
    bool isTodoAdded =  await db.addTodo(todoModel: newTodoModel);
    

    if(isTodoAdded){

      List<TodoModel> allTodos = await db.getAllTodoList();
      emit(SuccessfulState(allTodoStates: allTodos));
    }else{
      emit(FailureState(errorMsg: "Todo not added"));
    }

   }
   
   /// delete
   void deleteNote({required int id})async{
      
     emit(LoadingState());
     await db.deleteTodo(id);
     List<TodoModel> mData =  await db.getAllTodoList();
     emit(SuccessfulState(allTodoStates: mData));
 
   }


}
