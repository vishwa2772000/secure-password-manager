import 'dart:async';
import 'dart:io';

import 'package:personal/SOCIAL/model/SocialModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  Future<int> update(String table, Social model) async => await _database
    .update(table, model.toJson(), where: 'id = ?', whereArgs: [model.id]);

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "note1.db");
    print("Entered path $path");
    print(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE Social ("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "app_name TEXT,"
              "icon TEXT,"
              "color TEXT,"
              "password TEXT,"
              "user_name TEXT"

              ")");
        });
  }

  newSocial(Social social) async {
    final db = await database;
    var res = await db.insert("Social",social.toJson());
    print(res);
    return res;
  }

  getSocial(int id) async {
    final db = await database;
    var res = await db.query("Social", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Social.fromJson(res.first) : Null;
  }

  getAllSocial() async {
    final db = await database;
    var res = await db.query("Social");
    List<Social> list =
    res.isNotEmpty ? res.map((c) => Social.fromJson(c)).toList() : [];
    return list;
  }

  updateSocial(Social newSocialClient) async {
    final db = await database;
    var res = await db.update("Social", newSocialClient.toJson(),
        where: "id = ?", whereArgs: [newSocialClient.id]);
    print('Note Updated:');
    return res;
  }

  deleteSocial(int id) async {
    final db = await database;
    db.delete("Social", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.delete("Social");
  }
  addNote1InDB(Social new1Note)async{
    final db =await database;
    if(new1Note.userName.trim().isEmpty) new1Note.userName = 'Untitled Note';
    int id = await db.transaction((transaction) {
      transaction.rawInsert(
          'INSERT into Notes(title,username,appname,password) VALUES ("${new1Note.appName}", "${new1Note.userName}", "${new1Note.password}");');
    });
    new1Note.id = id;
    print('Note added: ${new1Note.appName} ${new1Note.userName}  ${new1Note.password}');
    return new1Note;

  }
}
