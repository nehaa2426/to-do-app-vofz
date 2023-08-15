import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vofz_app5/Todos.dart';

class articles extends StatefulWidget {
  @override
  _articlesState createState() => _articlesState();
}

class _articlesState extends State<articles> {
  String title = "";
  String description2 = "";
  String date = "";

  createTodos() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("ArticleAssignment").doc(title);

    Map<String, String> todos = {"ArticleTitle": title, "Description2": description2, "Date": date};
    documentReference.set(todos).whenComplete(() {
      print("$title created");
    });
  }
  deleteTodos(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("ArticleAssignment").doc(item);

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
                      title: Text ("New Articles Assignment"),
                      content: Container(
                        height: 240,
                        child: Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Assignment Title',
                                ),
                                onChanged: (String value) {
                                  title = value;
                                }
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Date Due',
                                ),
                                onChanged: (String value) {
                                  date = value;
                                }
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Description',
                                ),
                                onChanged: (String value) {
                                  description2 = value;
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
            stream: FirebaseFirestore.instance.collection("ArticleAssignment").snapshots(),
            builder: (context, snapshots) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                    snapshots.data.docs[index];
                    return Dismissible (
                        onDismissed: (direction) {
                          deleteTodos(documentSnapshot["ArticleTitle"]);
                        },
                        key: Key(index.toString()),
                        child: Card(
                            elevation: 4,
                            margin: EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                                title: Text(documentSnapshot["ArticleTitle"] + ' - ' + documentSnapshot["Date"]),
                                subtitle: Text(documentSnapshot["Description2"]),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    onPressed: () {
                                      deleteTodos(documentSnapshot
                                      ["ArticleTitle"]);
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
