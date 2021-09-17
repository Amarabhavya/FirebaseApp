import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/core/models/crew.dart';
import 'package:firebase_app/core/services/auth_service.dart';
import 'package:firebase_app/core/services/database.dart';
import 'package:firebase_app/widgets/crewlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Crew>>.value(
      value: DatabaseService().crews,
      initialData: [],
      catchError: (_, __) => [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Employee Crew"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: [
            // ignore: deprecated_member_use
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("Logout"),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: CrewList(),
      ),
    );
  }
}
