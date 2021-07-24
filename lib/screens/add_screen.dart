import 'package:bloc_todo/blocs/checkboxcubit/checkbox_cubit.dart';
import 'package:bloc_todo/blocs/dataBloc/note_bloc.dart';
import 'package:bloc_todo/blocs/dataBloc/note_event.dart';
import 'package:bloc_todo/blocs/dataBloc/note_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class Insert extends StatefulWidget {
  @override
  InsertState createState() => InsertState();
}

class InsertState extends State<Insert> {
  final _formkey = GlobalKey<FormState>();
  var _title = '';
  var _description = '';
  var _url="";
  startauthentication() {
    final validity = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState.save();
      BlocProvider.of<NoteBloc>(context).add(
          AddEvent(title: _title, description: _description, trash: false,url: _url));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckboxCubit>(
      create: (context) => CheckboxCubit(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Notes"),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            key: ValueKey('title'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field can\'t be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _title = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide()),
                                labelText: "Enter Title"),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            key: ValueKey('description'),
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 2,
                            maxLength: 70,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field can\'t be empty';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _description = value;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(8.0),
                                  borderSide: new BorderSide()),
                              labelText: "Enter Description",
                            ),
                          ),
                          SizedBox(height: 10),
                        BlocBuilder<CheckboxCubit, bool>(builder: (context, val) {
                         return Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children:[
                             Padding(
                               padding: const EdgeInsets.only(left:16),
                               child: Text("Add url",style: TextStyle(fontSize: 18),),
                             ),
                           Checkbox(

                               value: val,
                               onChanged: (value) {
                                 context.read<CheckboxCubit>().navigate(value);
                               }),
                           ],
                         );

                        }),
                          SizedBox(height: 10),
                      BlocBuilder<CheckboxCubit, bool>(builder: (context, val) {
                        return   Visibility(
                               visible: val,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                key: ValueKey('url'),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'This field can\'t be empty';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _url = value;
                                },
                                decoration: InputDecoration(
                                  labelText: "Enter url",
                                ),
                              ),
                            ),
                          );}),
                          SizedBox(height: 10),
                          Container(
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              height: 70,
                              child: RaisedButton(
                                  child: Text('ADD'),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    startauthentication();
                                  })),
                          SizedBox(height: 10),

                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
