import 'package:bloc_todo/offlinedata/offlinedata_model.dart';
import 'package:bloc_todo/offlinedata/offlinedata_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_model.dart';

class NoteRepository {
  var db = FirebaseFirestore.instance.collection("notes");

  addNote(NoteModel note) async {
    DocumentReference ref = db.doc();
    String id = ref.id;
    note.id = id;
    note.offlineId=int.parse(Timestamp.fromDate(DateTime.now()).seconds.toString());
    await db.doc(id).set(note.toMap());

    DatabaseProvider.db.insert(Note(trash: note.trash,id: note.offlineId,title: note.title,
    description: note.description,url: note.url)).then(
          (storednote) {
          print(note.offlineId);
          print(storednote.id);
        }
          );

  }

  Future<List<NoteModel>> getNotes() async {
    var data = await db.where('trash', isEqualTo: false).get();
    var notes =
        data.docs.map((note) => NoteModel.fromMap(note.data())).toList();
    return notes;
  }

  Future<List<NoteModel>> getTrashNotes() async {
    var data = await db.where('trash', isEqualTo: true).get();
    var notes =
        data.docs.map((note) => NoteModel.fromMap(note.data())).toList();
    return notes;
  }

  delNote(NoteModel note) async {
    await db.doc(note.id).update({'trash': true});
    DatabaseProvider.db.update(Note(id: note.offlineId,title: note.title,description: note.description
    ,url: note.url,trash: true)).then(
          (storednote) {
            print("success");
          }
    );
  }
}
