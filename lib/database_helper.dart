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

  Future<void> insertTask(Task task) async{
    Database _db = await database();
    await _db.insert('Tasks', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
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
}