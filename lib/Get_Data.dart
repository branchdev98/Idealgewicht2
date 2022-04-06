import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class PeopleList extends StatefulWidget {

  @override
  _PeopleListState createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //FirebaseFirestore firestore = FirebaseFirestore.instance;

  String barcode = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("People List")),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("review").snapshots(),
              builder: (context, snapshot)
              {
                if (!snapshot.hasData) {
                  return Text("Loading..");
                }
                return Expanded(
                  child: ListView.builder(
                    itemExtent: 190.0,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return _buildList(context, snapshot.data.documents[index]);

                    },

                  ),
                );


              },
            ),

          ],),
      ),);
  }
}
Widget _buildList(BuildContext context, DocumentSnapshot document) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15,top: 10,right: 15),
      child: Column(
        children: <Widget>[

          Expanded(
            child: Row(children: <Widget>[
              Expanded(
                child: Text("Full Name",),
              ),

              Text(": ",style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold
              ),),
              Expanded(
                child: Text(
                  document['comment'],
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
            ],),
          ),



          Expanded(
            child: Row(children: <Widget>[
              Expanded(
                child: Text("Phone Number",),
              ),

              Text(": ",style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold
              ),),
              Expanded(
                child: Text(
                  document['date'],
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              )

            ],),
          ),



          Expanded(
            child: Row(children: <Widget>[
              Expanded(
                child: Text("Email-Id"),
              ),

              Text(": ",style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold
              ),),
              Expanded(
                child: Text(
                  document['rating'],maxLines: 2,
                  style: TextStyle(
                      fontSize: 13, fontWeight: FontWeight.bold),
                ),
              )

            ],),
          ),





        ],
      ),
    ),
  );
}
