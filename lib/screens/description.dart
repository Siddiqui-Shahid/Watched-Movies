import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/utils/text.dart';
import 'package:untitled/screens/add_movie.dart';

class Description extends StatefulWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on;
  final bool isUser;

   Description(
      {Key key,
      this.name,

      this.description,
      this.bannerurl,
      this.posterurl,
      this.vote,
      this.launch_on, this.isUser})
      : super(key: key);

  @override
  State<Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
 bool isUser , isUploading = false;

 @override
  void initState() {
    // TODO: implement initState
   isUser = widget.isUser;
   super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return isUploading?Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 10.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.purple),
        )) : Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height:isUser ?MediaQuery.of(context).size.height-40.0: MediaQuery.of(context).size.height,
            child: ListView(children: [
              Container(
                  height: 250,
                  child: Stack(children: [
                    Positioned(
                      child: Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          widget.bannerurl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 10,
                        child: modified_text(text: '⭐ Average Rating - ' + widget.vote)),
                  ])),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.all(10),
                  child: modified_text(
                      text: widget.name != null ? widget.name : 'Not Loaded', size: 24)),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child:
                      modified_text(text: 'Releasing On - ' + widget.launch_on, size: 14)),
              Row(
                children: [
                  Container(
                    height: 200,
                    width: 100,
                    child: Image.network(widget.posterurl),
                  ),
                  Flexible(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: modified_text(text: widget.description, size: 18)),
                  ),
                ],
              )
            ]),
          ),
          isUser?GestureDetector(
            onTap: (){
              setState(() {
                isUploading = true;
              });
              add(title: widget.name , discription: widget.description , imageUrl: widget.posterurl , context: context);
              setState(() {
                isUploading = false;
              });
            },
            child: Container(
              width: double.infinity,
              height: 40.0,
              color: Colors.pink,
              child: Center(child: Text("Add to watched list",style: GoogleFonts.ubuntu(fontWeight: FontWeight.bold),)) ,

            ),
          ):const SizedBox(),
        ],
      ),
    );
  }

 void add( { String title , String discription , String imageUrl , BuildContext context } ) async {
   // save to db



   CollectionReference ref = FirebaseFirestore.instance
       .collection('users')
       .doc(FirebaseAuth.instance.currentUser.uid)
       .collection('notes');

   var data = {
     'title': title,
     'description': discription,
     'imageUrl':imageUrl,
     'created': DateTime.now(),
   };

   ref.add(data);

   Navigator.pop(context);
 }
}
