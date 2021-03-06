import 'package:firebase_app/core/models/user_model.dart';
import 'package:firebase_app/core/services/database.dart';
import 'package:firebase_app/widgets/constants.dart';
import 'package:firebase_app/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // form values
  late String? _currentName = null;
  late String? _currentSugars = null;
  late int? _currentStrength = null;

  @override
  Widget build(BuildContext context) {
    UserModel user = Provider.of<UserModel>(context);
    print("aaaaaaaaaaa");
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            // _currentName = userData!.name;
            // _currentStrength = userData.strength;
            // _currentSugars = userData.sugars;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 10.0),
                  DropdownButtonFormField(
                    value: _currentSugars ?? userData.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                  ),
                  SizedBox(height: 10.0),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor: Colors
                        .brown[(_currentStrength ?? userData.strength).toInt()],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) {
                      setState(() {
                        _currentStrength = val.round();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      //backgroundColor: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentSugars ?? snapshot.data!.sugars,
                              _currentName ?? snapshot.data!.name,
                              _currentStrength ?? snapshot.data!.strength);
                          Navigator.pop(context);
                        }
                      }),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
