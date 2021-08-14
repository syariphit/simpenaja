import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';

class Barang extends StatefulWidget {

  Barang({key}) : super(key: key);

  @override
  _BarangState createState() => _BarangState();
}

class _BarangState extends State<Barang> {
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
                  Text("Barang")
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