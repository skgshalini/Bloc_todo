abstract class NoteEvents {}

class AddEvent extends NoteEvents {
  String title;
  String description;
  String id;
  bool trash;
  AddEvent({this.title, this.description, this.id,this.trash});
}

class GetAllEvent extends NoteEvents {}
class GetAllTrashEvent extends NoteEvents {}

class DelEvent extends NoteEvents {
  String id;
  DelEvent({this.id});
}