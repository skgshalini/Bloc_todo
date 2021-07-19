import 'package:cloud_firestore/cloud_firestore.dart';

import 'data_model.dart';

class NoteRepository {
  var db = FirebaseFirestore.instance.collection("notes");

  addNote(NoteModel note) async {
    DocumentReference ref = db.doc();
    String id = ref.id;
    note.id = id;
    await db.doc(id).set(note.toMap());
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

  delNote(String id) async {
    await db.doc(id).update({'trash': true});
  }
}
