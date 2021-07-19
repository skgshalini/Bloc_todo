import 'package:bloc_todo/blocs/dataBloc/note_bloc.dart';
import 'package:bloc_todo/blocs/dataBloc/note_event.dart';
import 'package:bloc_todo/blocs/dataBloc/note_state.dart';
import 'package:bloc_todo/blocs/navcubit/navigation_cubit.dart';
import 'package:bloc_todo/components/homeNav.dart';
import 'package:bloc_todo/components/popupcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_screen.dart';
import '../utility/hero_dialog_route.dart';

var addPageContext;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<NoteBloc>(context).add(GetAllEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Notes")),
        body: BlocListener<NoteBloc, NoteStates>(
          listener: (context, state) {
            if (state is AddState) {
              Navigator.pop(addPageContext);
              BlocProvider.of<NoteBloc>(context).add(GetAllEvent());
              _showSnackbar(context);
            }
          },
          child: HomeNav(),
        ),
        floatingActionButton: BlocBuilder<NavigationCubit, int>(
          builder: (context, count) {
            bool vis;
            if (count == 0) {
              vis = true;
            } else
              vis = false;
            return Visibility(
              visible: vis,
              child: FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    addPageContext = context;
                    return Insert();
                  }));
                },
              ),
            );
          },
        ),
        bottomNavigationBar:
            BlocBuilder<NavigationCubit, int>(builder: (context, count) {
          return new BottomNavigationBar(
            currentIndex: count,
            onTap: (int index) {
              context.read<NavigationCubit>().navigate(index);
            },
            items: <BottomNavigationBarItem>[
              new BottomNavigationBarItem(
                icon: new Icon(Icons.home),
                title: new Text("Home"),
              ),
              new BottomNavigationBarItem(
                icon: new Icon(Icons.delete),
                title: new Text("Trash"),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _showSnackbar(BuildContext context) {
    final scaff = Scaffold.of(context);
    scaff.showSnackBar(SnackBar(
      content: Text("New note is added"),
      backgroundColor: Colors.black,
      duration: Duration(seconds: 3),
    ));
  }
}