import 'offlinedata_repository.dart';

class Note {
  String title;
  String description;
  String url;
  bool trash;
  int id;

  Note({this.id, this.title, this.description, this.url,this.trash});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TITLE: title,
      DatabaseProvider.COLUMN_DESCRIPTION: description,
      DatabaseProvider.COLUMN_URL: url,
      DatabaseProvider.COLUMN_ID: id,
      DatabaseProvider.COLUMN_TRASH: trash ? 1:0

    };

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    title = map[DatabaseProvider.COLUMN_TITLE];
    description = map[DatabaseProvider.COLUMN_DESCRIPTION];
    url = map[DatabaseProvider.COLUMN_URL];
    trash = map[DatabaseProvider.COLUMN_TRASH]==1?true:false;

  }
}