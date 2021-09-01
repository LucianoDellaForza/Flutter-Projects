import 'dart:io';

import 'package:news/src/models/item_model.dart';
import 'package:news/src/resources/repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory =
        await getApplicationDocumentsDirectory(); //returns a reference to a directory (folder) on device where we can save files
    final path =
        join(documentsDirectory.path, "items2.db"); // join path and name of DB

    //openDatabase fun either creates db if it doesnt exist or open existing one
    db = await openDatabase(path, version: 1,
        //onCreate is called only if db didnt exist
        onCreate: (Database newDb, int version) {
      // sql lite has no concept of boolean - instead we use INTEGER
      newDb.execute(""" 
        CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            type TEXT,
            by TEXT,
            time INTEGER,
            text TEXT,
            parent INTEGER,
            kids BLOB,
            dead INTEGER,
            deleted INTEGER,
            url TEXT,
            score INTEGER,
            title TEXT,
            descendants INTEGER
          )
        """);
    });
  }

  Future<ItemModel?> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    } else {
      return null;
    }
  }

  //no need to await anything here
  Future<int> addItem(ItemModel item) {
    return db.insert(
      "Items",
      item.toMapForDb(),
      conflictAlgorithm:
          ConflictAlgorithm.ignore, //if same ID, dont add, just ignore
    );
  }

  //too anoying to make (no usage in project)
  @override
  Future<List<int>> fetchTopIds() async {
    return [];
  }

  Future<int> clear() {
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();
