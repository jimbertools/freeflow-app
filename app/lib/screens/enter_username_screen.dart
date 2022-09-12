import 'dart:ui';

import 'package:app/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:app/models/user.dart';

class UserScreen extends StatefulWidget {
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  User user = new User(username: '');

  final _formKey = GlobalKey<FormState>();

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
                      controller: usernameController,
                      decoration: const InputDecoration(border: OutlineInputBorder()),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        user.username = usernameController.text;
                        print(user.username);
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailScreen(user: user)
                            )
                        );
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ),
          ),);
    }
}
