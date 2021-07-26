import 'package:bloc_todo/blocs/dataBloc/note_bloc.dart';
import 'package:bloc_todo/blocs/dataBloc/note_event.dart';
import 'package:bloc_todo/blocs/dataBloc/note_state.dart';
import 'package:bloc_todo/components/popupcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utility/hero_dialog_route.dart';

class Trash extends StatefulWidget {
  @override
  _TrashState createState() => _TrashState();
}

class _TrashState extends State<Trash> {
  void initState() {
    BlocProvider.of<NoteBloc>(context).add(GetAllTrashEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteStates>(
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetTrashState) {
          var notes;
          notes = state.notes;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    HeroDialogRoute(
                      builder: (context) => Center(
                        child: TodoPopupCard(note: notes[i]),
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: notes[i].id,
                  child: Card(
                    child: ListTile(
                      title: Text(notes[i].title),
                      subtitle: Text(notes[i].description),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
