import 'package:bloc_todo/data/data_model.dart';

abstract class NoteStates {}

class InitState extends NoteStates {}

class LoadingState extends NoteStates {}

class AddState extends NoteStates {}
class DelState extends NoteStates {
  List<NoteModel> dnotes;
  DelState({this.dnotes});
}

class GetState extends NoteStates {
  List<NoteModel> notes;
  GetState({this.notes});
}
class GetTrashState extends NoteStates {
  List<NoteModel> notes;
  GetTrashState({this.notes});
}

