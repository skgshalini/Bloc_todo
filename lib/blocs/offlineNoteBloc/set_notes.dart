
import 'package:bloc_todo/offlinedata/offlinedata_model.dart';

abstract class NoteEvent {}
class SetNotes extends NoteEvent {
  List<Note> noteList;


  SetNotes(List<Note> notes) {
    noteList = notes;
  }

}
class SetTrashNotes extends NoteEvent {

  List<Note> trashList;

  SetTrashNotes(List<Note> notes) {
    trashList = notes;
  }

}