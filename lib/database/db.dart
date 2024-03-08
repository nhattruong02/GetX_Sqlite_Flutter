import 'dart:io';
import 'package:flutter/material.dart';
import 'package:getx_sqlite/model/player.dart';
import 'package:getx_sqlite/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  static Database? _db;
  final String tablename = 'Users';
  final String tablename1 = 'Plays';
  final String iduser = 'id';
  final String columfullname = 'fullname';
  final String columusername = 'username';
  final String columphone = 'phone';
  final String columpassword = 'password';

  Future get database async {
    if (_db != null) return _db;
    _db = await _initializeDB('database.db');
    return _db;
  }

  Future _initializeDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);
    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future _create(Database db, int version) async {
    await db.execute('CREATE TABLE $tablename('
        '$iduser INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$columfullname TEXT NOT NULL,'
        '$columusername TEXT NOT NULL,'
        '$columphone TEXT NOT NULL,'
        '$columpassword TEXT NOT NULL )');
    await db.execute('CREATE TABLE $tablename1('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL,'
        'age INT NOT NULL,'
        'club TEXT NOT NULL,'
        'photo TEXT NOT NULL )');
  }
  Future getUsername(String username) async{
    final db = await database;
    print('db $username');
    var result = await db.rawQuery("SELECT $columusername FROM $tablename WHERE username LIKE '$username'");
    print(result);
    return result;
  }
  Future insertUser(User user) async {
    final db = await database;
    await db.insert(tablename,user.toMap());
    return user;
  }

  Future<bool> getUser(String username, String password) async {
    final db = await database;
    // List<Map> maps = await db.rawQuery("SELECT username,password FROM USERS");
    // List<Map> maps = await db.query(tablename, colums: ['username,password'],
    //     where: 'username = ? AND password = ?', whereArgs: [username,password]);
    //
    List<Map> maps = await db.rawQuery("SELECT username,password FROM $tablename"
        +" WHERE username LIKE '$username' AND"
        +" password LIKE '$password'");
    print(maps);
    if (maps.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<Player> insertPlayer(Player player) async {
    Database db = await database;
    await db.insert(tablename1, player.toMap());
    return player;
  }
  Future<int> updatetPlayer(Player player) async {
    Database db = await database;
    var result = await db.update(tablename1, player.toMap(), where: 'id = ?', whereArgs: [player.id]);
    return result;
    // return await db.rawUpdate(" UPDATE $tablename1 SET name = ${player.name}, "
    //     "age = ${player.age},club = ${player.club},photo = ${player.photo} WHERE id =${player.id}");

  }
  Future<List<Player>> getPlayer() async {
    Database db = await database;
    List<Map> maps = await db.rawQuery("SELECT * FROM $tablename1 ORDER BY id DESC");
    List<Player> players = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        players.add(Player.fromMap(maps[i]));
      }
    }
    return players;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tablename1, where: 'id = ?', whereArgs: [id]);
  }

  Future close() async{
    final db = await database;
    db.close();
  }
}
