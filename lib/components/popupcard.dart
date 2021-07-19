import 'package:bloc_todo/data/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoPopupCard extends StatelessWidget {
  const TodoPopupCard({Key key, this.note}) : super(key: key);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: note.id,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Container(
            width: 300,
            height: 150,
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                        child: Text(
                      note.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Text(
                      note.description,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
