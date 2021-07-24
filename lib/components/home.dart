import 'package:bloc_todo/blocs/dataBloc/note_bloc.dart';
import 'package:bloc_todo/blocs/dataBloc/note_event.dart';
import 'package:bloc_todo/blocs/dataBloc/note_state.dart';
import 'package:bloc_todo/blocs/navcubit/navigation_cubit.dart';
import 'package:bloc_todo/components/popupcard.dart';
import 'package:bloc_todo/components/videoPlayer.dart';
import 'package:bloc_todo/utility/hero_dialog_route.dart';
import 'package:bloc_todo/components/trash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNav extends StatefulWidget {
  @override
  _HomeNavState createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  void initState() {
    BlocProvider.of<NoteBloc>(context).add(GetAllEvent());
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
              } else if (state is GetState || state is DelState || state is AddState) {
                var notes;
                if (state is GetState) notes = state.notes;
                else if (state is DelState) notes = state.dnotes;
                else if (state is AddState) notes = state.anotes;
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, i) {
                    bool vis;
                   vis= notes[i].url==null||notes[i].url.length==0?false:true;
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
                            child: Column(

                              children: [
                                Center(child: Text(notes[i].title,
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                                ),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Flexible(child: Text(notes[i].description)),
                                  GestureDetector(
                                    child: Icon(Icons.delete),
                                    onTap: () {
                                      BlocProvider.of<NoteBloc>(context)
                                          .add(DelEvent(note: notes[i]));
                                    },
                                  ),
                                ],),
                                SizedBox(
                                  height: 12,
                                ),
                              // Visibility(
                              //   visible: vis,
                              //     child: Row(
                              //       children: [
                              //         Text("url : "),
                              //
                              //           Flexible (
                              //              child: Text(notes[i].url,style: TextStyle(
                              //               color: Colors.blue
                              //           ),),
                              //            ),
                              //
                              //       ],
                              //     )),
                              //   SizedBox(
                              //     height: 12,
                              //   ),
                              //   Padding(
                              //     padding: const EdgeInsets.only(right: 120),
                              //     child: Container(
                              //       height: 25,
                              //       child: Visibility(
                              //         visible: vis,
                              //         child: ElevatedButton(
                              //           onPressed:(){
                              //             Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder: (context) =>  VideoPLayer(url:notes[i].url),
                              //               ),
                              //             );
                              //         },child: Text("Play"),
                              //         ),
                              //       ),
                              //
                              //     ),
                              //   ),
                              //   SizedBox(
                              //     height: 12,
                              //   ),

                              ],
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
          );
  }
}
// ListTile(
// title: Text(notes[i].title),
// subtitle: Text(notes[i].description),
// trailing: GestureDetector(
// child: Icon(Icons.delete),
// onTap: () {
// BlocProvider.of<NoteBloc>(context)
//     .add(DelEvent(id: notes[i].id));
// },
// ),
// ),