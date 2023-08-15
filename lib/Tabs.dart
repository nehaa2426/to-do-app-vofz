import 'package:flutter/material.dart';
import 'package:vofz_app5/HomePage2.dart';
import 'package:vofz_app5/Subgroups.dart';
import 'package:vofz_app5/Team.dart';
import 'package:vofz_app5/Todos.dart';
import 'Subgroups.dart';

class Tabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(length: 3, child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Voices of Gen-Z', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w800)),
          bottom: TabBar(
            unselectedLabelColor: Colors.teal,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.teal
          ),
            tabs: [
              Tab(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.teal,
                          width: 0.5,
                        )
                    ),
                    child: Align(
                      alignment:Alignment.center,
                      child: Text("HOME"),
                    )
                ),
              ),
              Tab(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.teal,
                          width: 1,
                        )
                    ),
                    child: Align(
                      alignment:Alignment.center,
                      child: Text("TEAM"),
                    )
                ),
              ),
              Tab(
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: Colors.teal,
                          width: 1,
                        )
                    ),
                    child: Align(
                      alignment:Alignment.center,
                      child: Text("SUBGROUP"),
                    )
                ),
              ),
            ]
          )
        ),
        body: TabBarView(children: [
          HomePage3(),
          Team(),
          Nav(),
        ])
      )
      )
    );
  }
}


