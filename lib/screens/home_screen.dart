import 'dart:io';

import 'package:bloc_todo/blocs/dataBloc/note_bloc.dart';
import 'package:bloc_todo/blocs/dataBloc/note_event.dart';
import 'package:bloc_todo/blocs/dataBloc/note_state.dart';
import 'package:bloc_todo/blocs/internetBloc/internet_cubit.dart';
import 'package:bloc_todo/blocs/navcubit/navigation_cubit.dart';
import 'package:bloc_todo/components/home.dart';
import 'package:bloc_todo/components/popupcard.dart';
import 'package:bloc_todo/components/trash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_screen.dart';
import '../utility/hero_dialog_route.dart';
import 'offline_home.dart';
import 'offline_trash.dart';

var addPageContext;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

    @override
    void initState()  {
      _checkInternetConnection();
      super.initState();
    }
    Future<void> _checkInternetConnection() async {
      try {
        final response = await InternetAddress.lookup('www.kindacode.com');
        if (response.isNotEmpty) {
          BlocProvider.of<InternetCubit>(context).check(1);
        }
      } on SocketException catch (err) {
        BlocProvider.of<InternetCubit>(context).check(0);
        print(err);
      }
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
                //  BlocProvider.of<NoteBloc>(context).add(GetAllEvent());
                _showSnackbar(context);
              }
            },
            child: BlocBuilder<NavigationCubit, int>(
                builder: (context, count) {
                  if (count == 0)
                    {return BlocBuilder<InternetCubit, int>(
                  builder: (context, val) {
                    if(val==1)
                    return HomeNav();
                    return OfflineHome();

                  });}else {
                    return BlocBuilder<InternetCubit, int>(
                        builder: (context, val) {
                          if(val==1)
                            return Trash();
                          return OfflineTrash();

                        });
                    return Trash();
                  }
                }
            ),
          ),
          floatingActionButton:BlocBuilder<InternetCubit, int>(
      builder: (context, val) {
        if (val == 1) {
          return BlocBuilder<NavigationCubit, int>(
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
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) {
                      addPageContext = context;
                      return Insert();
                    }));
                  },
                ),
              );
            },
          );
        }
        return Visibility(visible: false,
            child: FloatingActionButton(onPressed: (){}));
      }
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

