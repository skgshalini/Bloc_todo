import 'package:bloc_todo/components/videoPlayer.dart';
import 'package:bloc_todo/data/data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoPopupCard extends StatelessWidget {
  const TodoPopupCard({Key key, this.note}) : super(key: key);
  final NoteModel note;

  @override
  Widget build(BuildContext context) {
    bool vis;
    if (note.url == null || note.url.length == 0)
      vis = false;
    else
      vis = true;
    return Hero(
      tag: note.id,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Container(
            width: 300,
            height: 180,
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
                  const SizedBox(
                    height: 8,
                  ),
                  Visibility(
                      visible: vis,
                      child: Row(
                        children: [
                          Text(
                            "URL : ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Flexible(
                            child: Text(
                              note.url,
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Visibility(
                      visible: vis,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VideoPLayer(url: note.url),
                              ),
                            );
                          },
                          child: Text("Play"),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
