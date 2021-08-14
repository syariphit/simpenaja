import 'package:ai_awesome_message/ai_awesome_message.dart';
import 'package:eminovel/helpers/constants.dart';
import 'package:eminovel/helpers/custom_colors.dart';
import 'package:eminovel/pages/app.dart';
import 'package:eminovel/pages/splashscreen.dart';
import 'package:eminovel/pages/user_info_screen.dart';
import 'package:eminovel/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:async';

class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;
  final LocalStorage storage = new LocalStorage('profile_data.json');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(CustomColors.primaryColor),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                User? user = await Authentication.signInWithGoogle(context: context);
                
                print('WOW');
                print(user);
                setState(() {
                  _isSigningIn = false;
                });

                if (user != null) {
                  set_session(
                    user.email,
                    user.displayName,
                    user.toString(),
                    user.photoURL,
                    true
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("assets/images/google_logo.png"),
                      height: 35.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Sign in with Google',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  void set_session(String? username, String? name, String? description, String? photo_url, bool is_auth) async {
    await storage.setItem('username', username);
    await storage.setItem('name', name);
    await storage.setItem('description', description);
    await storage.setItem('photo_url', photo_url);
    await storage.setItem('is_auth', photo_url);
    Navigator.push(
      context,
      AwesomeMessageRoute(
        awesomeMessage: AwesomeHelper.createAwesome(
          title: "Success", 
          message: "Wait a seconds!",
          tipType: TipType.COMPLETE,
        ),
        settings: RouteSettings(name: "/info"),
      ),
    );

    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return App();
      }));
    });
  }
}
