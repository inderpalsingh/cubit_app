import 'package:cubit_1/cubit/todo_cubit.dart';
import 'package:cubit_1/models/todo_model_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbAppConnection{
  
  DbAppConnection._();
  
  
  static final DbAppConnection db = DbAppConnection._();


  /// creating global static values
  static const String TABLE_NAME = 'todo';
  static const String TABLE_COLUMN_ID = 'id';
  static const String TABLE_COLUMN_TITLE = 'todo_title';
  static const String TABLE_COLUMN_DESC = 'todo_desc';
  
  
  
  Database? myDatabase;
  
  
  Future<Database> getDb() async {
    if(myDatabase != null){
      return myDatabase!;
    }else{
      myDatabase = await initDB();
      return myDatabase!;
    }
  }
  
  Future<Database> initDB () async{
    
    var rootPath = await getApplicationDocumentsDirectory();
    var actualPath = join(rootPath.path, 'todo_db.db');

    /////  db create
    return await openDatabase(actualPath, version: 1, onCreate: (db, version) async {
      ///// create table
      await db.execute('CREATE TABLE $TABLE_NAME ($TABLE_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_COLUMN_TITLE TEXT, $TABLE_COLUMN_DESC TEXT )');
      
    });
    
  }
  
  Future<List<TodoCubitModel>> getAllTodoList () async {
    var db = await getDb();
    
    var data = await db.query(TABLE_NAME);
    
    List<TodoCubitModel> todoList = [];
    
    for(Map<String,dynamic> todoDataMap in data){
      var dataModel = TodoCubitModel.fromMap(todoDataMap);
      todoList.add(dataModel);
    }
    
    return todoList;
    
  }
  
  addTodos({required TodoCubitModel todoCubitModel})async{
    var db = await getDb();
    db.insert(TABLE_NAME, todoCubitModel.toMap());
    
  }
  
  deleteTodos(int id)async{
    var db = await getDb();
    db.delete(TABLE_NAME, where: '$TABLE_COLUMN_ID = ? ', whereArgs: ['$id'] );
    
  }
  
  
}