import 'dart:async';

import 'package:ai_awesome_message/ai_awesome_message.dart';
import 'package:eminovel/helpers/constants.dart';
import 'package:eminovel/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localstorage/localstorage.dart';

class Login extends StatefulWidget {

  Login({key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LocalStorage storage = new LocalStorage('profile_data.json');
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  void set_session(String? username, String? name, String? description, String? photo_url, bool is_auth) async {
    await storage.setItem('username', username);
    await storage.setItem('name', name);
    await storage.setItem('description', description);
    await storage.setItem('photo_url', photo_url);
    await storage.setItem('is_auth', photo_url);
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return App();
    }));
  }
  
  @override
  void initState(){
  
  }

  void onLogin(){
    String username = usernameController.text;
    String password = passwordController.text;

    if(username == '' || username == null){
     Navigator.push(
        context,
        AwesomeMessageRoute(
          awesomeMessage: AwesomeHelper.createAwesome(
            title: "Validation", 
            message: "Username Wajib Diisi",
            tipType: TipType.WARN,
          ),
          settings: RouteSettings(name: "/info"),
        ),
      );
      return;
    }

    if(password == '' || password == null){
     Navigator.push(
        context,
        AwesomeMessageRoute(
          awesomeMessage: AwesomeHelper.createAwesome(
            title: "Validation", 
            message: "Password Wajib Diisi",
            tipType: TipType.WARN,
          ),
          settings: RouteSettings(name: "/info"),
        ),
      );
      return;
    }

    if(username == 'ari123'){
      if(password == 'rahasia'){
        Navigator.push(
          context,
          AwesomeMessageRoute(
            awesomeMessage: AwesomeHelper.createAwesome(
              title: "Response", 
              message: "Username dan Password Sesuai",
              tipType: TipType.COMPLETE,
            ),
            settings: RouteSettings(name: "/info"),
          ),          
        );

        set_session('ari123', 'Ari Ardiansyah', 'Fullstack Developer', 'https://i.pinimg.com/originals/8e/d6/c4/8ed6c4bb590f88ed59c070d1d0af285e.png', true);
      }else{
        Navigator.push(
          context,
          AwesomeMessageRoute(
            awesomeMessage: AwesomeHelper.createAwesome(
              title: "Response", 
              message: "Username dan Password Tidak Cocok",
              tipType: TipType.ERROR,
            ),
            settings: RouteSettings(name: "/info"),
          ),
        );
      }
    }else{
      Navigator.push(
        context,
        AwesomeMessageRoute(
          awesomeMessage: AwesomeHelper.createAwesome(
            title: "Response", 
            message: "Username Tidak Ditemukan",
            tipType: TipType.ERROR,
          ),
          settings: RouteSettings(name: "/info"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: new Image.asset(
                "assets/images/logo.png",
                width: 250.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                children: <Widget>[
                  inputText(Ionicons.person, 'Username', 1, TextInputType.text, usernameController, false),
                  Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
                  inputText(Ionicons.lock_closed, 'Password', 1, TextInputType.text, passwordController, true),
                  Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
                  btnAction(Icon(Ionicons.log_in), Theme.of(context).accentColor, 'LOGIN', onLogin),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0)),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).accentColor
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget btnAction(Icon icon, Color color, String title, onPressed){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),
    ),
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Text(title)
      ]
    ),
  );
}

Widget inputText(icon, String label, int maxlines, TextInputType type, TextEditingController controller, bool hide){
  return Container(
    child: new ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 300.0,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        obscureText: hide,
        maxLines: maxlines == 0 ? null : maxlines,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(      
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.8), 
              width: 2, 
              style: BorderStyle.solid 
            )
          ),  
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.8), 
              width: 2, 
              style: BorderStyle.solid 
            )
          ),
          prefixIcon: Icon(
            icon,
            color: rei_primaryColor,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: rei_primaryColor, 
              width: 2, 
              style: BorderStyle.solid 
            ),
          ),
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.grey.withOpacity(0.8),
            fontWeight: FontWeight.bold
          ),
        ),
      )
    )
  );
}