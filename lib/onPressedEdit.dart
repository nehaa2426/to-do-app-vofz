import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vofz_app5/Todos.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String valueChoose;
  List listItem = [
    "Podcast", "Articles", "Creatives"
  ];
  String name2 = "";
  String description5 = "";
  String pronouns2 = "";

  createTodos() {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("TeamMember").doc(name2);

    Map<String, String> todos = {"MemberName": name2, "Description4": description5, "Pronouns": pronouns2};
    documentReference.set(todos).whenComplete(() {
      print("$name2 created");
    });
  }
  deleteTodos(item) {
    DocumentReference documentReference =
    FirebaseFirestore.instance.collection("TeamMember").doc(item);

    documentReference.delete().whenComplete(() {
      print("$item deleted");
    });
  }
  @override
  Widget build(BuildContext context) {
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
                      title: Text ("New Team Member"),
                      content: Container(
                        height: 300,
                        child: Column(
                          children: [
                            TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                ),
                                onChanged: (String value) {
                                  name2 = value;
                                }
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                                decoration: InputDecoration(
                                  helperMaxLines: 2,
                                  hintText: 'Pronouns',
                                ),
                                onChanged: (String value) {
                                  pronouns2 = value;
                                }
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                                decoration: InputDecoration(
                                  helperMaxLines: 4,
                                  hintText: 'Description',
                                ),
                                onChanged: (String value) {
                                  description5 = value;
                                }
                            ),
                            SizedBox(height: 30),
                            DropdownButton(
                              hint: Text("Select Subgroup: "),
                              value: valueChoose,
                              onChanged: (newValue) {
                                setState(() {
                                  valueChoose = newValue;
                                });
                              },
                              items: listItem.map((valueItem) {
                                return DropdownMenuItem(
                                  value: valueItem,
                                  child: Text(valueItem),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      ),
                      actions: <Widget> [
                        FlatButton(
                            onPressed: () {
                              createTodos();
                              Navigator.of(context).pop();
                            },
                            child: Text("Add New Member", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
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
            stream: FirebaseFirestore.instance.collection("TeamMember").snapshots(),
            builder: (context, snapshots) {
              return ListView.builder(
                // shrinkWrap: false,
                  itemCount: snapshots.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                    snapshots.data.docs[index];
                    return Dismissible (
                        onDismissed: (direction) {
                          deleteTodos(documentSnapshot["MemberName"]);
                        },
                        key: Key(index.toString()),
                        child: Card(
                            elevation: 4,
                            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: ListTile(
                                title: Text(documentSnapshot["MemberName"] + ' ' + documentSnapshot["Pronouns"]),
                                subtitle: Text(documentSnapshot["Description4"]),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.grid_view,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      deleteTodos(documentSnapshot
                                      ["MemberName"]);
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
