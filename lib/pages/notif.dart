import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

class Notif extends StatefulWidget {

  Notif({key}) : super(key: key);

  @override
  _NotifState createState() => _NotifState();
}

class _NotifState extends State<Notif> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState(){
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: <Widget>[
                  Text("Notif")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget test(){
  return Text("wow");
}