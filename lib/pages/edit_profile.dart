import 'dart:ui';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfile createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  decoration: new InputDecoration(
                    hintText: 'masukan nama lengkap',
                    labelText: 'Nama Lengkap',
                    icon: Icon(Icons.people),
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0)),
                  ),
                ),
                TextFormField(
                  autofocus: true,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: new InputDecoration(
                          hintText: 'masukan password',
                          labelText: 'Password',
                          icon: Icon(Icons.lock),
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  obscureText: true,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(children: [
                    TextField(
                        decoration: new InputDecoration(
                      hintText: 'masukan ulang password',
                      labelText: 'Confirm Password',
                      icon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    )),
                    TextFormField(
                      obscureText: true,
                    ),
                  ]),
                ),
              ],
            ),
          )),
    );
    // ignore: dead_code
    Validator:
    (value) {
      if (value.isEmpty) {
        return 'Isi Nama Lengkap dan Password';
      }
      _formKey.currentState!.validate();
      return null;
    };
    RaisedButton(
      child: Text(
        'SAVE',
        style: TextStyle(color: Colors.white),
      ),
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
      },
    );
  }
}
