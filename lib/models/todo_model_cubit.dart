import 'package:cubit_1/db/db_connection.dart';

class TodoModel {
  int id;
  String title;
  String desc;

  TodoModel({this.id = 0, required this.title, required this.desc});

  //// map to model

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map[DbAppConnection.TABLE_COLUMN_ID],
      title: map[DbAppConnection.TABLE_COLUMN_TITLE],
      desc: map[DbAppConnection.TABLE_COLUMN_DESC],
    );
  }

  ///// model to map

  Map<String, dynamic> toMap() {
    return {
      DbAppConnection.TABLE_COLUMN_TITLE: title,
      DbAppConnection.TABLE_COLUMN_DESC: desc
    };
  }
}
