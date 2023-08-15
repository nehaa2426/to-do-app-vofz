import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vofz_app5/Todos.dart';

class creatives extends StatefulWidget {
  @override
  _creativesState createState() => _creativesState();
}

class _creativesState extends State<creatives> {
  String input2 = "";
  String description3 = "";

  createTodos() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("CreativesAssignment").doc(input2);

    Map<String, String> todos = {"CreativesTitle": input2, "Description": description3};
    documentReference.set(todos).whenComplete(() {
      print("$input2 created");
    });
  }
  deleteTodos(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("CreativesAssignment").doc(item);

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
                      title: Text ("New Creatives Assignment"),
                      content: Container(
                        height: 100,
                        child: Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Assignment Title',
                                ),
                                onChanged: (String value) {
                                  input2 = value;
                                }
                            ),
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                ),
                                onChanged: (String value) {
                                  description3 = value;
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
            stream: FirebaseFirestore.instance.collection("CreativesAssignment").snapshots(),
            builder: (context, snapshots) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                    snapshots.data.docs[index];
                    return Dismissible (
                        onDismissed: (direction) {
                          deleteTodos(documentSnapshot["CreativesTitle"]);
                        },
                        key: Key(index.toString()),
                        child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                                title: Text(documentSnapshot["CreativesTitle"]),
                                subtitle: Text(documentSnapshot["Description"]),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      deleteTodos(documentSnapshot
                                      ["CreativesTitle"]);
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
