import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> listNotes = [];

  var titleController = TextEditingController();
  var descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),

      body: ListView.builder(
        itemCount: listNotes.length,
          itemBuilder: (_, index){
        return ListTile(
          title: Text(listNotes[index]['title']),
          subtitle: Text(listNotes[index]['desc']),
          trailing: Icon(Icons.delete),
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          /// overlays
          titleController.clear();
          descController.clear();

          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(51))
            ),
              context: context,
              builder: (_){
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade200,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(51))
                  ),
                  height: 800,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Add Note', style: TextStyle(fontSize: 21),),
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
                            OutlinedButton(onPressed: (){

                              listNotes.add({
                                "title" : titleController.text,
                                "desc" : descController.text,
                              });

                              setState(() {

                              });

                              Navigator.pop(context);
                            }, child: Text('Add')),
                            OutlinedButton(onPressed: (){
                              Navigator.pop(context);
                            }, child: Text('Cancel')),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });


        },
        child: Icon(Icons.add),
      ),
    );
  }
}