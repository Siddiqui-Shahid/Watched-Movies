import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:untitled/utils/text.dart';
import 'package:untitled/widgets/toprated.dart';
import 'package:untitled/widgets/trending.dart';
import 'package:untitled/widgets/tv.dart';

import 'homepage.dart';
import 'login_page.dart';

class Home extends StatefulWidget {
  final bool isUser;

  const Home({Key key, this.isUser = true}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apikey = 'dd58e891010ad0da8e4e7e7eea6cd735';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZDU4ZTg5MTAxMGFkMGRhOGU0ZTdlN2VlYTZjZDczNSIsInN1YiI6IjYxYWNkMGE2YzA3MmEyMDA0MzAwYjFkOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.xNrDJRzywq8nuR7AIVGeOqvJbGJ6juVHzDCdrjbyXjM';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    print('............................................');
    print((trendingresult));

    print('............................................');
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: modified_text(text: 'Moviezz'),
          backgroundColor: Colors.transparent,
          actions: [
           !widget.isUser?const SizedBox(): FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Icon(Icons.menu),),
            !widget.isUser?const SizedBox(): FlatButton(
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );          },
              child: Text("Logout"),
            ),
          ],
        ),
        body: ListView(
          children: [
            TV(tv: tv),
            TrendingMovies(
              trending: trendingmovies,
              isUser: widget.isUser,
            ),
            TopRatedMovies(
              toprated: topratedmovies,
            ),
          ],
        ));
  }
}
