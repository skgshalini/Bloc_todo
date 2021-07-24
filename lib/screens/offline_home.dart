import 'package:bloc_todo/blocs/offlineNoteBloc/noteBloc.dart';
import 'package:bloc_todo/blocs/offlineNoteBloc/set_notes.dart';
import 'package:bloc_todo/offlinedata/offlinedata_model.dart';
import 'package:bloc_todo/offlinedata/offlinedata_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfflineHome extends StatefulWidget {
  @override
  _OfflineHomeState createState() => _OfflineHomeState();
}

class _OfflineHomeState extends State<OfflineHome> {
  void initState() {
    super.initState();
    DatabaseProvider.db.getNotes().then(
          (noteList) {
        BlocProvider.of<OfflineNoteBloc>(context).add(SetNotes(noteList));
        print(noteList);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.grey,
      child: BlocBuilder<OfflineNoteBloc, List<Note>>(
        builder: (context, noteList) {
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              print("noteList: $noteList");

              Note note = noteList[index];
              return Card(
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(note.title, style: TextStyle(fontSize: 26)),
                  subtitle: Text(
                    "Description: ${note.description}",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              );
            },
            itemCount: noteList.length,
          );
        },
      ),
    );
  }
}
