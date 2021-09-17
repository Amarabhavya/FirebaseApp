import 'package:firebase_app/core/models/crew.dart';
import 'package:flutter/material.dart';

class CrewTile extends StatelessWidget {
  final Crew crew;
  CrewTile({required this.crew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[crew.strength],
          ),
          title: Text(crew.name),
          subtitle: Text('Takes ${crew.sugars} sugar(s)'),
        ),
      ),
    );
  }
}
