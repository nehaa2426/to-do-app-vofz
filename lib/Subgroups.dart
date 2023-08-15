import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vofz_app5/Todos.dart';

class Groups extends StatefulWidget {
  @override
  _GroupsState createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {

  String input = "";
  String description = "";
  String date = "";

  createTodos() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("MyAssignment").doc(input);

    Map<String, String> todos = {"AssignmentTitle": input, "Description": description, "Date": date};
    documentReference.set(todos).whenComplete(() {
      print("$input created");
  });
  }
  deleteTodos(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("MyAssignment").doc(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }
  @override
  Widget build(BuildContext context) {
    Nav();
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
                title: Text ("New Podcast Assignment"),
                content: Container(
                  height: 200,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Assignment Title',
                        ),
                        onChanged: (String value) {
                          input = value;
                        }
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Due Date',
                          ),
                          onChanged: (String value) {
                            date = value;
                          }
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Description',
                          ),
                          onChanged: (String value) {
                            description = value;
                          }
                      ),
                    ],
                  ),
                ),
                actions: <Widget> [
                  FlatButton(
                    onPressed: () {
                      createTodos();
                      Navigator.of(context).pop();
                    },
                    child: Text("Add Assignment")
                  )
                ]
              );
            });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("MyAssignment").snapshots(),
        builder: (context, snapshots) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshots.data.docs.length,
            itemBuilder: (context, index) {
              DocumentSnapshot documentSnapshot =
                  snapshots.data.docs[index];
              return Dismissible (
                onDismissed: (direction) {
                  deleteTodos(documentSnapshot["AssignmentTitle"]);
                },
                key: Key(index.toString()),
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: ListTile(
                    title: Text(documentSnapshot["AssignmentTitle"] ),
                      // subtitle: Text(documentSnapshot["Description"]),
                      // subtitle: Text(documentSnapshot["Description"]),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        deleteTodos(documentSnapshot
                        ["AssignmentTitle"]);
                      }
                    )
                  )
                )
              );
            }
          );
        }
      )
    );
  }
}
