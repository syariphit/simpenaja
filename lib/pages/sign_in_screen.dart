import 'package:ai_awesome_message/ai_awesome_message.dart';
import 'package:eminovel/helpers/custom_colors.dart';
import 'package:eminovel/pages/login.dart';
import 'package:eminovel/utils/authentication.dart';
import 'package:eminovel/widgets/google_sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localstorage/localstorage.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/sign_in_vector.png',
                        height: 250,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'SimpenAja',
                      style: TextStyle(
                        color: CustomColors.primaryColor,
                        fontSize: 35,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: Authentication.initializeFirebase(context: context),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error initializing Firebase');
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GoogleSignInButton();
                  }
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.primaryColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}