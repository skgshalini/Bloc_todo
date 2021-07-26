import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'data_model.dart';

class NoteRepository {
  static const String TABLE_NOTE = "note";
  static const String COLUMN_OFFLINE_ID = "offlineId";
  static const String COLUMN_TITLE = "title";
  static const String COLUMN_TRASH = "trash";
  static const String COLUMN_DESCRIPTION = "description";
  static const String COLUMN_URL = "url";
  static const String COLUMN_ID = "id";
  var db = FirebaseFirestore.instance.collection("notes");
  Database _database;

  Future<Database> get database async {
    print("database getter called");

    // if (_database != null) {
    //   return _database;
    // }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'note.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating note table");

        await database.execute(
          "CREATE TABLE $TABLE_NOTE ("
              "$COLUMN_OFFLINE_ID INTEGER PRIMARY KEY,"
              "$COLUMN_TITLE TEXT,"
              "$COLUMN_DESCRIPTION TEXT,"
              "$COLUMN_URL TEXT,"
              "$COLUMN_ID TEXT,"
              "$COLUMN_TRASH INTEGER"
              ")",
        );
      },
    );
  }
  Future<List<NoteModel>> getLocalNotes() async {
    final db = await database;
    String whereString = '"trash" = ?';
    List<dynamic> whereArguments = [0];
    var notes = await db
        .query(TABLE_NOTE, columns: [COLUMN_OFFLINE_ID,COLUMN_ID, COLUMN_TITLE, COLUMN_DESCRIPTION, COLUMN_URL,COLUMN_TRASH],
        where: whereString,
        whereArgs: whereArguments);

    var noteList = notes.map((note) => NoteModel.fromMap(note)).toList();

    return noteList;
  }
  Future<List<NoteModel>> getLocalTrashNotes() async {
    final db = await database;
    String whereString = '"trash" = ?';
    List<dynamic> whereArguments = [1];
    var notes = await db
        .query(TABLE_NOTE, columns: [COLUMN_OFFLINE_ID,COLUMN_ID, COLUMN_TITLE, COLUMN_DESCRIPTION, COLUMN_URL,COLUMN_TRASH],
        where: whereString,
        whereArgs: whereArguments);
    var noteList = notes.map((note) => NoteModel.fromMap(note)).toList();

    return noteList;
  }

   addLocalNote(NoteModel note) async {
    final db = await database;
    await db.insert(TABLE_NOTE, note.toMap());
  }


  Future<int> delLocalNote(NoteModel note) async {
    final db = await database;

    return await db.update(
      TABLE_NOTE,
      note.toMap(),
      where: "offlineId = ?",
      whereArgs: [note.offlineId],
    );
  }


  addNote(NoteModel note) async {


    DocumentReference ref = db.doc();
    String id = ref.id;
    note.id = id;
    note.offlineId=int.parse(Timestamp.fromDate(DateTime.now()).seconds.toString());
    await db.doc(id).set(note.toMap());
    await addLocalNote(note);}





  Future<List<NoteModel>> getNotes() async {
    bool check = await _checkInternetConnection();
    if(check) {
      var data = await db.where('trash', isEqualTo: 0).get();
      var notes =
      data.docs.map((note) => NoteModel.fromMap(note.data())).toList();
      return notes;
    }
    else
      return await getLocalNotes();
  }

  Future<List<NoteModel>> getTrashNotes() async {
    bool check = await _checkInternetConnection();
    if(check) {
      var data = await db.where('trash', isEqualTo: 1).get();
      var notes =
      data.docs.map((note) => NoteModel.fromMap(note.data())).toList();
      return notes;
    }
    else
      return await getLocalTrashNotes();
  }

  delNote(NoteModel note) async {
    await db.doc(note.id).update({'trash': 1});
    note.trash=true;
    await delLocalNote(note);
  }
  Future<bool> _checkInternetConnection() async {

      try {
        final response = await InternetAddress.lookup('www.kindacode.com');
        if (response.isNotEmpty) {
         return true;
        }

      } on SocketException catch (err) {
       return false;

      }

  }
}
