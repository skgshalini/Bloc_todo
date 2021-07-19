import 'package:bloc_todo/blocs/dataBloc/note_bloc.dart';
import 'package:bloc_todo/blocs/dataBloc/note_event.dart';
import 'package:bloc_todo/blocs/dataBloc/note_state.dart';
import 'package:bloc_todo/blocs/navcubit/navigation_cubit.dart';
import 'package:bloc_todo/components/popupcard.dart';
import 'package:bloc_todo/utility/hero_dialog_route.dart';
import 'package:bloc_todo/screens/trash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNav extends StatefulWidget {
  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, count) {
        if (count == 0) {
          BlocProvider.of<NoteBloc>(context).add(GetAllEvent());
          return Column(
            children: [
              Expanded(child: BlocBuilder<NoteBloc, NoteStates>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is GetState || state is DelState) {
                    var notes;
                    if (state is GetState)
                      notes = state.notes;
                    else if (state is DelState) notes = state.dnotes;
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
                              child: Container(
                                height: 60,
                                child: ListTile(
                                  title: Text(notes[i].title),
                                  subtitle: Text(notes[i].description),
                                  trailing: GestureDetector(
                                    child: Icon(Icons.delete),
                                    onTap: () {
                                      BlocProvider.of<NoteBloc>(context)
                                          .add(DelEvent(id: notes[i].id));
                                    },
                                  ),
                                ),
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
              )),
            ],
          );
        } else
          return Trash();
      },
    );
  }
}
