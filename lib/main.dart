import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/all_movies.dart';
import 'package:untitled/screens/homepage.dart';
import 'package:untitled/screens/login_page.dart';
import 'package:untitled/utils/text.dart';
import 'package:untitled/widgets/toprated.dart';
import 'package:untitled/widgets/trending.dart';
import 'package:untitled/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import 'Auth/google_login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        scaffoldBackgroundColor: Color(0xff070706),
      ),
      // which used to re-authenticate every time App was opened
      // earlier I was simply calling the Login page
      // fixed it here
      // home: LoginPage(),
      home:
      FirebaseAuth.instance.currentUser == null ? LoginPage() : Home(),
    );
  }
}

