class NoteModel {
  String title;
  String description;
  String id;
  bool trash;

  NoteModel({this.title, this.description, this.id,this.trash});

  toMap() => {
    "title" : title,
    "description" : description,
    "id" : id,
    "trash" : trash,
  };


  NoteModel.fromMap(Map<String, dynamic> map) :
        title = map["title"],
        description = map["description"],
        id = map["id"],
        trash = map["trash"];

}