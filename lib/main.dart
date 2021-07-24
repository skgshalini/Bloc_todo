import 'package:bloc_todo/blocs/internetBloc/internet_cubit.dart';
import 'package:bloc_todo/blocs/navcubit/navigation_cubit.dart';
import 'package:bloc_todo/screens/add_screen.dart';
import 'package:bloc_todo/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/dataBloc/note_bloc.dart';
import 'blocs/dataBloc/note_state.dart';
import 'blocs/offlineNoteBloc/noteBloc.dart';
import 'blocs/offlineNoteBloc/set_notes.dart';
import 'blocs/videoBloc/video_bloc.dart';
import 'blocs/videoBloc/video_events.dart';
import 'blocs/videoBloc/video_state.dart';
import 'data/data_repository.dart';
import 'offlinedata/offlinedata_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      BlocProvider<OfflineNoteBloc>(
          create: (context) => OfflineNoteBloc(List<Note> ()),
          child: BlocProvider<InternetCubit>(
             create: (context) => InternetCubit(1),
          child: BlocProvider<VideoBloc>(
        create: (context) => VideoBloc(Init(),Eve()),
        child: BlocProvider<NavigationCubit>(
      create: (context) => NavigationCubit(0),
      child: BlocProvider<NoteBloc>(
        create: (context) => NoteBloc(InitState(), NoteRepository()),
        child: MaterialApp(
          home: Home(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
      ),
      ),
      ),
  );
}
