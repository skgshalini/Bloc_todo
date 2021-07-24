import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'offlinedata_model.dart';

class DatabaseProvider {
  static const String TABLE_NOTE = "note";
  static const String COLUMN_ID = "id";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_TRASH = "trash";
  static const String COLUMN_DESCRIPTION = "description";
  static const String COLUMN_URL = "url";


  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'noteDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating note table");

        await database.execute(
          "CREATE TABLE $TABLE_NOTE ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_TITLE TEXT,"
              "$COLUMN_DESCRIPTION TEXT,"
              "$COLUMN_URL TEXT,"
              "$COLUMN_TRASH INTEGER"
              ")",
        );
      },
    );
  }

  Future<List<Note>> getNotes() async {
    final db = await database;
    String whereString = '"trash" = ?';
    List<dynamic> whereArguments = [0];
    var notes = await db
        .query(TABLE_NOTE, columns: [COLUMN_ID, COLUMN_TITLE, COLUMN_DESCRIPTION, COLUMN_URL,COLUMN_TRASH],
        where: whereString,
        whereArgs: whereArguments);

    List<Note> noteList = List<Note>();
    print("note");
    notes.forEach((currentNote) {
      Note note = Note.fromMap(currentNote);
     print("note : $note");
      noteList.add(note);
    });

    return noteList;
  }
  Future<List<Note>> getTrashNotes() async {
    final db = await database;
    String whereString = '"trash" = ?';
    List<dynamic> whereArguments = [1];
    var notes = await db
        .query(TABLE_NOTE, columns: [COLUMN_ID, COLUMN_TITLE, COLUMN_DESCRIPTION, COLUMN_URL,COLUMN_TRASH],
        where: whereString,
        whereArgs: whereArguments);

    List<Note> noteList = List<Note>();
    print("note");
    notes.forEach((currentNote) {
      Note note = Note.fromMap(currentNote);
      print("note : $note");
      noteList.add(note);
    });

    return noteList;
  }

  Future<Note> insert(Note note) async {
    final db = await database;
    await db.insert(TABLE_NOTE, note.toMap());
    return note;
  }


  Future<int> update(Note note) async {
    final db = await database;

    return await db.update(
      TABLE_NOTE,
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }
}