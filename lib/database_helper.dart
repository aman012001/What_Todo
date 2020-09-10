import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Models/Task.dart';
import 'Models/todo.dart';

class DatabaseHelper{

  Future<Database> database() async {
    return openDatabase( join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) async {
        // Run the CREATE TABLE statement on the database.
        await db.execute(
          "CREATE TABLE Tasks(id INTEGER PRIMARY KEY,title TEXT, description TEXT)",
        );
        await db.execute(
            "CREATE TABLE todotable(id INTEGER PRIMARY KEY,title TEXT, isDone INTEGER, taskId INTEGER)",
        );
        return db;
      },
      version: 2,
    );
  }

  Future<int> insertTask(Task task) async{
    int taskId = 0;
    Database _db = await database();
    await _db.insert('Tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value){
          taskId=value;
    });
    return taskId;
  }

  Future<void> updateTaskDescription(int id, String description) async{
    Database _db = await database();
    await _db.rawUpdate("UPDATE  Tasks SET description = '$description' WHERE id ='$id'");
  }

  Future<void> updateTaskTitle(int id, String title) async{
    Database _db = await database();
    await _db.rawUpdate("UPDATE  Tasks SET title = '$title' WHERE id ='$id'");
  }

  Future<void> insertTodo(Todo todo) async{
    Database _db = await database();
    await _db.insert('todotable', todo.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Task>> getListofTasks() async{
    Database _db =  await database();
    List<Map<String, dynamic>> taskMap = await _db.query('Tasks');
    print("hello2");
    return List.generate(taskMap.length, (index){
      return Task(
          id: taskMap[index]['id'],
          title: taskMap[index]['title'],
          description: taskMap[index]['description']
      );
    });
  }

  Future<List<Todo>> getListofTodos(int taskId) async{
    Database _db =  await database();
    List<Map<String, dynamic>> todoMap = await _db.rawQuery("SELECT* FROM todotable WHERE taskId = $taskId");
    print("hello2");
    return List.generate(todoMap.length, (index){
      return Todo(
          id: todoMap[index]['id'],
          title: todoMap[index]['title'],
          taskId: todoMap[index]['description'],
          isDone: todoMap[index]['isDone'],
      );
    });
  }
  Future<void> updateTodoDone(int id, int isDone) async{
    Database _db = await database();
    print("isdone status: $isDone");
    await _db.rawUpdate("UPDATE  todotable SET isDone = '$isDone' WHERE id ='$id'");
    print("todo updated");
  }

  Future<void> deleteTask(int id) async{
    Database _db = await database();
    await _db.rawDelete("DELETE FROM Tasks WHERE id= '$id'");
    await _db.rawDelete("DELETE FROM todotable WHERE taskId =$id");
  }
}