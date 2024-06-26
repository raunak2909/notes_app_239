import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_239/note_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NoteModel> listNotes = [];

  var dtFormat = DateFormat.MMMMEEEEd();

  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: listNotes.isNotEmpty
          ? ListView.builder(
              itemCount: listNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  onTap: () {
                    /// update
                    ///
                    ///

                    titleController.text = listNotes[index].title;
                    descController.text = listNotes[index].desc;

                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(51))),
                        context: context,
                        builder: (_) {
                          return bottomSheetUI(
                              isUpdate: true,
                              updateIndex: index,
                              createdAt: listNotes[index].createdAt);
                        });
                  },
                  title: Text(listNotes[index].title),
                  subtitle: Text(listNotes[index].desc),
                  trailing: Column(
                    children: [
                      Text(dtFormat.format(DateTime.fromMillisecondsSinceEpoch(
                          listNotes[index].createdAt))),
                      SizedBox(height: 11),
                      InkWell(
                          onTap: () {
                            ///delete
                            listNotes.removeAt(index);
                            setState(() {});
                          },
                          child: Icon(Icons.delete)),
                    ],
                  ),
                );
              })
          : Center(
              child: Text('No Notes yet..'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /// overlays
          titleController.clear();
          descController.clear();

          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(51))),
              context: context,
              builder: (_) {
                return bottomSheetUI();
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget bottomSheetUI(
      {bool isUpdate = false, int updateIndex = -1, createdAt = ""}) {
    ///add is default
    return Container(
      decoration: BoxDecoration(
          color: Colors.blueGrey.shade200,
          borderRadius: BorderRadius.vertical(top: Radius.circular(51))),
      height: 800,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              isUpdate ? 'Update Note' : 'Add Note',
              style: TextStyle(fontSize: 21),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: titleController,
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: descController,
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () {
                      if (isUpdate) {
                        /*listNotes[updateIndex] = {
                          "title": titleController.text,
                          "desc": descController.text,
                          "createdAt": createdAt
                        };*/

                        listNotes[updateIndex] = NoteModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: createdAt);

                      } else {
                        /*listNotes.add({
                      "title": titleController.text,
                      "desc": descController.text,
                      "createdAt" : DateTime.now().millisecondsSinceEpoch
                    });*/

                        listNotes.add(NoteModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: DateTime.now().millisecondsSinceEpoch));
                      }

                      setState(() {});

                      Navigator.pop(context);
                    },
                    child: Text(isUpdate ? 'Update' : 'Add')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
