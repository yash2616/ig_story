import 'dart:async';
import 'dart:developer';

import 'package:ig_story/data/model/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../core/app_constants.dart';

class DatabaseService {
  DatabaseService._privateConstructor();

  static final DatabaseService _instance = DatabaseService._privateConstructor();

  factory DatabaseService() {
    return _instance;
  }

  static Database? _db;

  Future<Database> initializeDB() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'ig_story.db');

    // Increment(+1) the db version(SQFLITE_DB_VERSION) when adding new DDL commands.
    // Refer createUpdatedTables method to make changes to existing DDL commands.
    Database database = await openDatabase(path,
        version: SQFLITE_DB_VERSION,
        onConfigure: (Database db) {},
        onCreate: createTable,
        onUpgrade: createUpdatedTables);

    return database;
  }

  Future<Database> get db async {
    _db ??= await initializeDB();
    return _db!;
  }

  FutureOr<void> createTable(Database db, int version) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS Users(
          userName NVARCHAR PRIMARY KEY,
          profilePic NVARCHAR NOT NULL,
        )
      ''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS Story(
          mediaUrl NVARCHAR,
          seen INTEGER,
          FOREIGN KEY (userName) REFERENCES Users (userName),
        )
      ''');
  }

  FutureOr<void> createUpdatedTables(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await createTable(db, newVersion);
    }
  }

  Future<List<UserModel>> getAllStories() async {
    try{
      List<UserModel> userStories = [];
      var database = await db;

      var result = await database.rawQuery('''
        SELECT * FROM Users
      ''');

      for(var userData in result){
        final List<Map<String, dynamic>> stories = await getStoryListByUsername((userData['userName'] ?? '') as String);
        userStories.add(
          UserModel.fromMap({
            'userName': userData['userName'],
            'profilePic': userData['profilePic'],
            'stories': stories.map((formattedStory){
              formattedStory['seen'] = formattedStory['seen'] == 1 ? true : false;
              return formattedStory;
            }),
          })
        );
      }

      return userStories;
    }
    catch (err, s) {
      log(err.toString());
      log(s.toString());
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getStoryListByUsername(String username) async {
    try{
      var database = await db;

      var result = await database.rawQuery('''
        SELECT * FROM Story
        WHERE userName = '$username'
      ''');

      return result;
    }
    catch (err, s) {
      log(err.toString());
      log(s.toString());
      return [];
    }
  }

  Future<bool> cacheNewStory(UserModel userModel) async {
    try {
      var database = await db;

      await database.rawQuery('''
          INSERT OR IGNORE INTO Users
          VALUES(?,?)
        ''', [
        userModel.userName,
        userModel.profilePic,
      ]);

      for(var story in userModel.stories){
        database.rawQuery(
          '''
          INSERT OR IGNORE INTO Story
          VALUES(?,?) 
          ''',
          [
            story.mediaUrl,
            story.seen ? 1 : 0
          ],
        );
      }

      return true;
    } catch (err, s) {
      log(err.toString());
      log(s.toString());
      return false;
    }
  }

  Future<bool> cacheMultipleStories(List<UserModel> users) async {
    try {
      for (var element in users) {
        cacheNewStory(element);
      }

      return true;
    }
    catch (err, s) {
      log(err.toString());
      log(s.toString());
      return false;
    }
  }

  Future<void> clearStoryCache() async {
    try {
      var database = await db;

      await database.rawQuery('''
          DELETE FROM Users
        ''');

      await database.rawQuery('''
          DELETE FROM Story
        ''');
    } catch (err, s) {
      log(err.toString());
      log(s.toString());
    }
  }

}
