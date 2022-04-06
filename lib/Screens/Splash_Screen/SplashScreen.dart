import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Models/Posts.dart';

import 'dart:async';

import 'package:vtm/Screens/Global_File/GlobalFile.dart';
import 'package:vtm/Services/audioPlayer.dart';
import 'package:http/http.dart' as http;

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {


  final String imagename = 'assets/images/logo.svg';
  Widget get svg => SvgPicture.asset(
    imagename,width: 50,height: 50,
    color: VtmBlue,


  );

  Future<List<Posts>> getPosts() async {
//calling api
    List<Posts> Listofpost = new List();
    await  http.get(Uri.parse("http://blog.vtm-stein.de/wp-json/wp/v2/posts?status=publish&order=desc&per_page=5&page=1&categories=3")).then((res){
      print(res.body);
      var Storedataofpost = jsonDecode(res.body);
      print(Storedataofpost);
      Listofpost = (Storedataofpost as List).map((data)=>Posts.fromJson(data)).toList();
      print(Listofpost.length);
     /* print(jsonEncode(Listofpost).toString());*/
    });
    Global.allPosts=Listofpost;
    return Listofpost;
  }

  startTime() async {

    getPosts();


    User user = FirebaseAuth.instance.currentUser;
      if(user==null){

        await FirebaseAuth.instance.signInAnonymously().then((value) {

          Global.user=value.user;

        });

      }   else{

        Global.user=user;

      }



    await CommonPlayer.assetsAudioPlayer.open(
        Playlist(
            audios: [
              Audio("assets/audio/001.mp3", metas: Metas(
                title:  trackone_text,
                artist: aboutTitleText,
                album: trackone_text,
                image: MetasImage.asset("assets/images/bgForPlayer.png"), //can be MetasImage.network
              ),),
              Audio("assets/audio/002.mp3", metas: Metas(
                title:  introduction_text,
                artist: aboutTitleText,
                album: introduction_text,
                image: MetasImage.asset("assets/images/bgForPlayer.png"), //can be MetasImage.network
              ),)
            ],

        ),
         

         autoStart: false,
        loopMode: LoopMode.none,
        showNotification: true);

    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('Bottombar');
  }

  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          children: [
            Spacer(),
            Container(height: 200,width: 200,

                child: SvgPicture.asset(imagename,color: VtmBlue,)),
            SizedBox(height: 20,),
            Text(splashTitle??"The Relief of Pain",style: TextStyle(
                color: VtmBlue,
                fontSize: 32
            ),textAlign: TextAlign.center,),
            Spacer(),
            Text(splashSubTitle??"VTM Dr. Stein",style: TextStyle(
              color: VtmBlue, fontSize: 28
            ),),
            SizedBox(height: 2,),
          /*  Text("Dr.Stein",style: TextStyle(
                color: VtmBlue,fontWeight: FontWeight.bold,
                fontSize: 20
            ),),*/
            Spacer(),
          ],
        ),
      ),
    );
  }
}
