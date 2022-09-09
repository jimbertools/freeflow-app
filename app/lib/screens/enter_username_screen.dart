import 'dart:ui';

import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:app/models/user.dart';

class UserScreen extends StatefulWidget {
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  // @override
  // void initState() {
  //   super.initState();
  // }

  final _formKey = GlobalKey<FormState>();
  User user = User(username: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Username'),
                      // validator: (String value) {
                      //   if (value.isEmpty) {
                      //     return 'Please enter some text';
                      //   }
                      //   return null;
                      // },
                      onSaved: (value) {
                        if(value != null) {
                          print(value);
                          user.username = value;
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final form = _formKey.currentState;
                            if (form != null && form.validate()) {
                              form.save();
                              print('huts');


                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(user: user)
                                )
                              );
                            }

                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ),
          ),);
    }
}
