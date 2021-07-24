class NoteModel {
  String title;
  String description;
  String id;
  bool trash;
  String url;
  int offlineId;
  NoteModel({this.title, this.description, this.id,this.trash,this.url});

  toMap() => {
    "title" : title,
    "description" : description,
    "id" : id,
    "trash" : trash,
    "url" : url,
    "offlineId": offlineId,
    
  };


  NoteModel.fromMap(Map<String, dynamic> map) :
        title = map["title"],
        description = map["description"],
        id = map["id"],
        trash = map["trash"],
        offlineId = map["offlineId"],
        url = map["url"];


}