import 'package:flutter/material.dart';
import 'package:untitled/Auth/google_login.dart';
import 'package:untitled/screens/all_movies.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [
            Colors.red,Colors.yellow
          ])),),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: ElevatedButton(

                      onPressed: () {
                        signInWithGoogle(context);
                      },
                      child: Text(
                        "Continue With Google",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: "lato",
                        ),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[700],
                          ),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(
                              vertical: 12.0,
                              horizontal: 12.0,
                            ),
                          )
                      ),
                    ),
                  ),
                ),
                //
                SizedBox(
                  height: 10.0,
                ),
                TextButton(onPressed: (){Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home(isUser :false)),
                );}, child: Text('Skip Login'),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}