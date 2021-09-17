import 'package:firebase_app/core/models/crew.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'crewtile.dart';

class CrewList extends StatefulWidget {
  const CrewList({Key? key}) : super(key: key);

  @override
  _CrewListState createState() => _CrewListState();
}

class _CrewListState extends State<CrewList> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    final crews = Provider.of<List<Crew>>(context);
    // print('aaaaaaaaaaa');
    // crews.forEach((crew) {
    //   print(crew.name);
    //   print(crew.sugars);
    //   print(crew.strength);
    // });

    return ListView.builder(
        itemCount: crews.length,
        itemBuilder: (context, index) {
          return CrewTile(crew: crews[index]);
        });
  }
}
