import 'package:bloc_todo/blocs/offlineNoteBloc/set_notes.dart';
import 'package:bloc_todo/offlinedata/offlinedata_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfflineNoteBloc extends Bloc<NoteEvent, List<Note>> {
  OfflineNoteBloc(List<Note> initialState) : super(initialState);
  @override
  Stream<List<Note>> mapEventToState(NoteEvent event) async* {
    if (event is SetNotes) {
      yield event.noteList;
    }
    if (event is SetTrashNotes) {
      yield event.trashList;
    }
  }
}