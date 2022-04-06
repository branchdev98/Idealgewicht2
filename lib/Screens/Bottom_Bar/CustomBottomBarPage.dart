import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vtm/Screens/Blog_Screen/Blog_InfoPage.dart';
import 'package:vtm/Screens/Blog_Screen/Blog_Page.dart';
import 'package:vtm/Screens/Global_File/GlobalFile.dart';
import 'package:vtm/Screens/History_Screen/HistoryScreen.dart';
import 'package:vtm/Screens/InfoScreen/Info_page.dart';
import 'package:vtm/Screens/More_Screen/More_Info.dart';
import 'package:vtm/Screens/MusicPlayer_Home/VtmHome.dart';
import 'package:vtm/Screens/Youtube_Videos/YoutubeVideo_Screen.dart';
import 'package:connectivity/connectivity.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {

  test()async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    test();
    //Firebase.initializeApp().whenComplete(() => print("completed"));
  }
  @override
  Widget build(BuildContext context) {

    List<Widget> pageName = [
      InfoScreen(refreshScreen: refreshScreen,),
      VtmHomePage(refreshScreen: refreshScreen,),
      Youtubevidepage(refreshScreen: refreshScreen,),
      HistoryPage(refreshScreen: refreshScreen,),
      BlogScreen(refreshScreen: refreshScreen,),
      BlogInfo(refreshScreen: refreshScreen,)

    ];


    return Scaffold(
    bottomNavigationBar:OrientationBuilder(
      builder: (context, orientation) {
        return  orientation == Orientation.portrait ? Global.fullScreenPlayer?SizedBox(): CustomBottomBar(click: (){
            refreshScreen();
          },) : SizedBox();
      },
    ),
    body: pageName[Global.currentPageIndex],
    );
  }

  refreshScreen(){
    setState(() {
    });
  }

}
