
import 'package:bloc_todo/data/data_model.dart';
import 'package:bloc_todo/data/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvents, NoteStates> {
  NoteRepository repo;
  NoteBloc(NoteStates initialState, this.repo) : super(initialState);

  @override
  Stream<NoteStates> mapEventToState(NoteEvents event) async*{
    if(event is GetAllEvent) {
      yield LoadingState();
      var notes = await repo.getNotes();
      yield GetState(notes: notes);

    } if(event is GetAllTrashEvent) {
      yield LoadingState();
      var notes = await repo.getTrashNotes();
      yield GetTrashState(notes: notes);

    }
    else if (event is AddEvent) {
      await repo.addNote(NoteModel(title: event.title, description: event.description, id: event.id, trash: event.trash));
      yield LoadingState();
      var anotes = await repo.getNotes();
      yield AddState(anotes: anotes);
    } else if (event is DelEvent) {
      await repo.delNote(event.id);
      yield LoadingState();
     var dnotes = await repo.getNotes();
      yield DelState(dnotes: dnotes);
    }
  }

}