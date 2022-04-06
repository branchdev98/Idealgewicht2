import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Screens/Global_File/GlobalFile.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:share/share.dart';


class HistoryPage extends StatefulWidget {
  VoidCallback refreshScreen;

  HistoryPage({this.refreshScreen});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  TextEditingController comment = new TextEditingController();
  //FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String ratingvalue="5";
  DateTime selectedDate = DateTime.now();
  bool isFavorite = false;


  sharedata(){
    Share.share("text");
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void createRecord(double rating) async {

    print("Creating Record with $rating");

    DocumentReference ref = await firestore.collection("users/${Global.user.uid}/review")
        .add({
      'date': DateTime.now().toString().split(' ')[0],
      'rating': rating,
      'comment': comment.text.toString(),
      'isFavourite':isFavorite,
      'timestamp':DateTime.now()
    }).whenComplete(() {
      widget.refreshScreen();
      setState(() {

      });
    });


    print(ref.firestore);
  }

  void updateRecord() async {
    DocumentReference ref = await firestore.collection("users/${Global.user.uid}/review")
        .add({
      'date': DateTime.now().toString().split(' ')[0],
      'rating': ratingvalue,
      'comment': comment.text.toString(),
      'isFavourite':isFavorite
    });
    print(ref.firestore);
  }

  _displayDialog(BuildContext context) async {
    var rating =5.0;
    bool isFavorite = false;
    return showDialog(

        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(didTheSessionHelpText??'Did the session help?',style: TextStyle(color: VtmBlue),)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Container(
              decoration: BoxDecoration(
                  //color: VtmLightBlue.withOpacity(0.2),

                  borderRadius:
                  BorderRadius.all(Radius.circular(40))),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(color: VtmGrey.withOpacity(0.9),thickness: 1,),
                  SizedBox(
                    height: 10,
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select date'),
                      ),


                    ],
                  ),*/
                 /* Text(
                    "Did the session help?",
                    style: TextStyle(
                        color: VtmGrey.withOpacity(0.9),
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        programStartedText??"Program Started: ",
                        style: TextStyle(
                          fontSize: 14,
                          color:VtmGrey.withOpacity(0.9),
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w600,),
                      ),
                      Text(DateTime.now().toString().split(' ')[0],
                          style: TextStyle(
                              color: VtmGrey.withOpacity(0.9),
                              fontSize: 14,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w600))
                    ],
                  ),


                  SizedBox(
                    height: 10,
                  ),
                  SmoothStarRating(
                    color: VtmBlue,
                    rating: rating,
                    borderColor: VtmGrey,
                    isReadOnly: false,
                    size: 40,
                    filledIconData: Icons.star,
                    //halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 2.0,
                    onRated: (value) {
                      rating=value;
                      ratingvalue=value.toString();
                      print("rating value " + ratingvalue);
                      // print("rating value dd -> ${value.truncate()}");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: comment,
                      maxLines: 3,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: VtmGrey.withOpacity(0.2),
                                width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: VtmGrey.withOpacity(0.2),
                                width: 1.0),
                          ),
                          hintText:
                          historyHintText??"Your personal remark about the session",
                          hintStyle: TextStyle(
                              color: VtmGrey.withOpacity(0.9),
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 14)),
                      style: TextStyle(
                          color: VtmGrey.withOpacity(0.9),
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  SizedBox(height: 10,),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: VtmWhite)
                    ),
                    color: VtmBlue,
                    child: new Text(submitButton??'SUBMIT',style: TextStyle(
                      color: VtmWhite
                    ),),
                    onPressed: () {
                      print("RATTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTIIIIIIIIIIIIIIINGGGGGGGGGGGG>>");
                      print(rating);
                      //print(ratingvalue);

                        createRecord(rating);
                        Show_toast_Now(newEntrySubmitted??"Review Submitted", VtmBlue);
                        Navigator.of(context).pop();
                      comment.text="";


                    },
                  )
                  /*Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/images/dustbin.svg',
                            color: VtmBlack,
                          )),
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                          onTap: () {
                            isFavorite = !isFavorite;
                            setState(() {});
                          },
                          child: isFavorite
                              ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                              : Icon(
                            Icons.favorite,
                            color: VtmGrey,
                          )),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/images/share.svg',
                            color: VtmGrey,
                          )),
                    ],
                  )*/
                ],
              ),
            ),
            /*actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  createRecord();
                  Navigator.of(context).pop();
                },
              )
            ],*/
          );
        });
  }


  @override
  void initState() {
    // TODO: implement initState
    //Firebase.initializeApp().whenComplete(() => print("completed"));
    setState(() {
      //Firebase.initializeApp().whenComplete(() => print("completed"));
    });
    //getData();
    super.initState();

    print(Global.user.uid);

  }

  @override
  Widget build(BuildContext context) {
    var rating = 3.0;
    bool isFavorite = false;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        refresh: widget.refreshScreen,
      ),
      //bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              CustomAppBar(
                addiconclr: VtmBlue,
                clickonmoreicon: (){
                  _displayDialog(context);

                },
                text: historyTitleText??"HISTORY",
                menuiconclr: VtmBlue,
                clickonmenuicon: () {
                  print("clicked");
                  _scaffoldKey.currentState.openDrawer();
                },
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("users/${Global.user.uid}/review").orderBy('timestamp',descending: true).snapshots(),
                builder: (context, snapshot)
                {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Expanded(child: Center(child: Text("Loading..")));
                  }
                  return snapshot.data.docs.isEmpty?Expanded(
                    child: Center(child: Text(noHistory??"No History")),
                  ): Expanded(

                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return _buildList(context, snapshot.data.docs[index],(){setState(() {

                        });});

                      },

                    ),
                  );


                },
              ),
              //Getdataa(context)



            ],
          ),
        ),
      ),
    );
  }
}


Widget _buildList(BuildContext context, DocumentSnapshot document,VoidCallback refreshScreen) {



  bool isFavorite = document['isFavourite'];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var rating = double.parse(document['rating'].toString());

  _editDialog(BuildContext context,{double ratingnew,String text}) async {
    double rating =ratingnew;
    bool isFavorite = false;

    TextEditingController editText = TextEditingController(text: text);

    return showDialog(

        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(didTheSessionHelpText??'Did the session help?',style: TextStyle(color: VtmBlue),)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            content: Container(
              decoration: BoxDecoration(
                //color: VtmLightBlue.withOpacity(0.2),

                  borderRadius:
                  BorderRadius.all(Radius.circular(40))),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Divider(color: VtmGrey.withOpacity(0.9),thickness: 1,),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        programStartedText??"Program Started: ",
                        style: TextStyle(
                          fontSize: 14,
                          color:VtmGrey.withOpacity(0.9),
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w600,),
                      ),
                      Text(DateTime.now().toString().split(' ')[0],
                          style: TextStyle(
                              color: VtmGrey.withOpacity(0.9),
                              fontSize: 14,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w600))
                    ],
                  ),


                  SizedBox(
                    height: 10,
                  ),
                  SmoothStarRating(
                    color: VtmBlue,
                    rating: rating,
                    borderColor: VtmGrey,
                    isReadOnly: false,
                    size: 40,
                    filledIconData: Icons.star,
                    //halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 2.0,
                    onRated: (value) {
                      rating=value;
                      print("rating value " + rating.toString());
                      // print("rating value dd -> ${value.truncate()}");
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextField(
                      controller: editText,
                      maxLines: 3,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: VtmGrey.withOpacity(0.2),
                                width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: VtmGrey.withOpacity(0.2),
                                width: 1.0),
                          ),
                          hintText:
                          historyHintText??"Your personal remark about the session",
                          hintStyle: TextStyle(
                              color: VtmGrey.withOpacity(0.9),
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 14)),
                      style: TextStyle(
                          color: VtmGrey.withOpacity(0.9),
                          fontWeight: FontWeight.w500),
                    ),
                  ),

                  SizedBox(height: 10,),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: VtmWhite)
                    ),
                    color: VtmBlue,
                    child: new Text(submitButton??'SUBMIT',style: TextStyle(
                        color: VtmWhite
                    ),),
                    onPressed: () async {
                      Navigator.of(context).pop();

                      refreshScreen();

                      print(rating);
                      print("asdasfdawwesdf");
                      //print(ratingvalue);

                      await firestore.collection("users/${Global.user.uid}/review").doc(document.id)
                          .update({
                        'date': DateTime.now().toString().split(' ')[0],
                        'rating': rating,
                        'comment': editText.text
                      }).catchError((onError){
                        print(onError.message);
                      });
                      editText.text="";
                      Show_toast_Now(entryUpdated??"Review Submitted", VtmBlue);



                    },
                  )
                  /*Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/images/dustbin.svg',
                            color: VtmBlack,
                          )),
                      SizedBox(
                        width: 40,
                      ),
                      InkWell(
                          onTap: () {
                            isFavorite = !isFavorite;
                            setState(() {});
                          },
                          child: isFavorite
                              ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                              : Icon(
                            Icons.favorite,
                            color: VtmGrey,
                          )),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/images/share.svg',
                            color: VtmGrey,
                          )),
                    ],
                  )*/
                ],
              ),
            ),
            /*actions: <Widget>[
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  createRecord();
                  Navigator.of(context).pop();
                },
              )
            ],*/
          );
        });
  }

  sharedata(){
    Share.share("$shareTextStarting $linkOfApp $beforeStarRatingText ${document['rating']} $afterStarRatingText ${document['comment']}");
    //Share.share("Program On: " + document['date']+ "\nDid the session help ?: " + document['rating'] + "\nReview: " + document['comment']);
  }

  _updateData() async {
    await firestore
        .collection('users/${Global.user.uid}/review')
        .doc(document.id)
        .update({'isFavourite':isFavorite});
  }



  void Deletedialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        return AlertDialog(
          title: new Text(deleteTitle??"Delete",style: TextStyle(color: VtmBlue),),
          content: new Text(deleteDesText??  "Do you really want to delete this history entry?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20
                    ),
                    child:  GestureDetector(
                        onTap: (){
                          Navigator.of(context).pop();
                        },child: new Text(deleteCancelButton??"Cancel",style: TextStyle(color: VtmBlue))),
                  ),

                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            FlatButton(
              child: new Text( deleteOkButton??"Ok",style: TextStyle(color: VtmBlue)),
              onPressed: () async{
                Navigator.of(context).pop();

                await firestore.collection("users/${Global.user.uid}/review").doc(document.id).delete();
                Show_toast_Now(deleteOkDeleted??"Deleted Successfully", Colors.red);

                refreshScreen();
              },
            ),
          ],
        );
      },
    );
  }




  return Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5.0,
          child: Container(
            decoration: BoxDecoration(
                color: VtmWhite,
                borderRadius:
                BorderRadius.all(Radius.circular(16))),

            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    didTheSessionHelpText??"Did the session help ?",
                    style: TextStyle(
                        color: VtmBlue,
                        fontSize: 16,
                        fontFamily: 'Montserrat-Regular',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        programStartedText??"Program Started: ",
                        style: TextStyle(
                          color: VtmGrey.withOpacity(0.9),
                          fontSize: 16,
                          fontFamily: 'Montserrat-Regular',
                          fontWeight: FontWeight.w600,),
                      ),
                      Text(document['date'],
                          style: TextStyle(
                              color: VtmGrey.withOpacity(0.9),
                              fontSize: 15,
                              fontFamily: 'Montserrat-Regular',
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  SmoothStarRating(
                    color: VtmBlue,
                    rating:double.parse(document['rating'].toString()),
                    borderColor: VtmGrey.withOpacity(0.9),
                    isReadOnly: true,
                    size: 40,
                    filledIconData: Icons.star,
//halfFilledIconData: Icons.star_half,
                    defaultIconData: Icons.star_border,
                    starCount: 5,
                    allowHalfRating: true,
                    spacing: 2.0,

                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: <Widget>[

                        /*Row(
                          children: <Widget>[
                            Text("Review:",style: TextStyle(
                                color: VtmBlack,fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),),
                          ],
                        ),*/
                        SizedBox(height: 10,),
                        SingleChildScrollView(
                          child: Container(
                            width: 400,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: VtmGrey.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SingleChildScrollView(
                                child: Text(document['comment'],style: TextStyle(
                                    color: VtmGrey.withOpacity(1.0),fontSize: 14,
                                    fontFamily: 'Montserrat-Regular',
                                    fontWeight: FontWeight.w500
                                ),),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      GestureDetector(
                        onTap: (){
                          Deletedialog(context);
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.width * Global.dairyIconSize,
                            width: MediaQuery.of(context).size.width * Global.dairyIconSize,
                            child: SvgPicture.asset(
                              'assets/images/dustbin.svg',
                              color: VtmGrey,
                            )),
                      ),

                      SizedBox(
                        width: 40,
                      ),


                      isFavorite==true
                          ? GestureDetector(
                        onTap: (){
                        isFavorite=false;
                        print(isFavorite);
                        _updateData();
                      },
                            child: Icon(

                        Icons.favorite,
                        color: Colors.red,
                              size: MediaQuery.of(context).size.width * Global.dairyIconSize+5,
                      ),
                          )
                          : GestureDetector(
                        onTap: (){
                          isFavorite=true;
                          print(isFavorite);
                          _updateData();
                        },
                            child: Icon(
                        Icons.favorite,
                        color: VtmGrey,size: MediaQuery.of(context).size.width * Global.dairyIconSize+5,
                      ),
                          ),
                      SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: (){
                          sharedata();
                        },
                        child: Container(
                            height: MediaQuery.of(context).size.width * Global.dairyIconSize,
                            width: MediaQuery.of(context).size.width * Global.dairyIconSize,
                            child: SvgPicture.asset(
                              'assets/images/share.svg',
                              color: VtmGrey,
                            )),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: (){
                          isFavorite=true;
                          print(isFavorite);
                          _editDialog(context,text: document['comment'],ratingnew: double.parse(document['rating'].toString()));
                        },
                        child: Icon(
                          Icons.edit,
                          color: VtmGrey,size: MediaQuery.of(context).size.width * Global.dairyIconSize+5,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      SizedBox(height: 20,)
    ],
  );
}
