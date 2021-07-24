import 'package:bloc_todo/data/data_model.dart';

abstract class NoteEvents {}

class AddEvent extends NoteEvents {
  String title;
  String description;
  String id;
  bool trash;
  String url;

  AddEvent({this.title, this.description, this.id,this.trash,this.url});
}

class GetAllEvent extends NoteEvents {}
class GetAllTrashEvent extends NoteEvents {}

class DelEvent extends NoteEvents {
 NoteModel note;
  DelEvent({this.note});
}