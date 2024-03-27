import 'package:flutter/material.dart';
import 'package:notes_app_239/todo_model.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  List<TodoModel> listTodo = [];

  var titleController = TextEditingController();
  var descController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: ListView.builder(
        itemCount: listTodo.length,
          itemBuilder: (_, index){
        return CheckboxListTile(
          tileColor: listTodo[index].isCompleted ? Colors.green : Colors.orange,
          controlAffinity: ListTileControlAffinity.leading,
            value: listTodo[index].isCompleted,
            onChanged: (value){
              listTodo[index].isCompleted = value!;
              setState(() {

              });
            },
          title: Text(listTodo[index].title, style: TextStyle(
            decoration: listTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none
          ),),
          subtitle: Text(listTodo[index].desc, style: TextStyle(
              decoration: listTodo[index].isCompleted ? TextDecoration.lineThrough : TextDecoration.none
          ),),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              context: context,
              shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.vertical(top: Radius.circular(51))),
              builder: (_){
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
              isUpdate ? 'Update Todo' : 'Add Todo',
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

                        listTodo[updateIndex] = TodoModel(
                            title: titleController.text,
                            desc: descController.text,
                            createdAt: createdAt);

                      } else {
                        /*listNotes.add({
                      "title": titleController.text,
                      "desc": descController.text,
                      "createdAt" : DateTime.now().millisecondsSinceEpoch
                    });*/

                        listTodo.add(TodoModel(
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
