import 'dart:ffi';

import 'package:cubit_1/models/todo_model_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbAppConnection {
  DbAppConnection._();

  static final DbAppConnection db = DbAppConnection._();

  /// creating global static values
  static const String TABLE_NAME = 'todo';
  static const String TABLE_COLUMN_ID = 'id';
  static const String TABLE_COLUMN_TITLE = 'todo_title';
  static const String TABLE_COLUMN_DESC = 'todo_desc';

  Database? myDatabase;

  Future<Database> getDb() async {
    if (myDatabase != null) {
      return myDatabase!;
    } else {
      myDatabase = await initDB();
      return myDatabase!;
    }
  }

  Future<Database> initDB() async {
    var rootPath = await getApplicationDocumentsDirectory();
    var actualPath = join(rootPath.path, 'todo_db.db');

    /////  db create
    return await openDatabase(actualPath, version: 1,
        onCreate: (db, version) async {
      ///// create table
      await db.execute(
          'CREATE TABLE $TABLE_NAME ($TABLE_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT, $TABLE_COLUMN_TITLE TEXT, $TABLE_COLUMN_DESC TEXT )');
    });
  }

  Future<List<TodoModel>> getAllTodoList() async {
    var db = await getDb();

    var data = await db.query(TABLE_NAME);

    List<TodoModel> todoList = [];

    for (Map<String, dynamic> todoDataMap in data) {
      var dataModel = TodoModel.fromMap(todoDataMap);
      todoList.add(dataModel);
    }

    return todoList;
  }

  
   Future<bool> addTodo({required TodoModel todoModel}) async {
    var db = await getDb();
    var checkDb = await db.insert(TABLE_NAME, todoModel.toMap()); //// checkDB =>  show me how many rows effected
    return checkDb>0;
    
  }
 
/*
  Future<bool> addTodo({required TodoModel todoModel}) async {
    var db = await getDb();
    var check = db.insert(TABLE_NAME, todoModel.toMap()); //// checkDB =>  show me how many rows effected
    return check>0;
  }

  */

  deleteTodo(int id) async {
    var db = await getDb();

    db.delete(TABLE_NAME, where: "$TABLE_COLUMN_ID = ?", whereArgs: ['$id']);
  }

  updateTodo({
    required TodoModel todoModel,
  }) async {
    var db = await getDb();
    db.update(TABLE_NAME, todoModel.toMap(),
        where: '$TABLE_COLUMN_ID =?', whereArgs: ['${todoModel.id}']);
  }
}
