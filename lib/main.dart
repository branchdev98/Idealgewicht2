import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Screens/Global_File/GlobalFile.dart';
import 'package:vtm/inapp.dart';
import 'package:vtm/newTestFile.dart';
import 'Screens/Blog_Screen/Blog_InfoPage.dart';
import 'Screens/Blog_Screen/Blog_Page.dart';
import 'Screens/Bottom_Bar/CustomBottomBarPage.dart';
import 'Screens/History_Screen/HistoryScreen.dart';
import 'Screens/InfoScreen/Info_page.dart';
import 'Screens/MusicPlayer_Home/VtmHome.dart';
import 'Screens/Splash_Screen/SplashScreen.dart';
import 'Screens/Youtube_Videos/YoutubeVideo_Screen.dart';



Future<void> main() async {
//  InAppPurchaseConnection.enablePendingPurchases();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
      fontFamily: "Montserrat-SemiBold",
        appBarTheme: AppBarTheme(
          color: VtmWhite,iconTheme: IconThemeData(color: VtmBlue)
        )

      ),

      debugShowCheckedModeBanner: false,
      title: appTitle_text??'The Relief of Pain',
      home: SplashScreenPage(),
      routes: {

        'Musicplayer_VtmHome': (context) => VtmHomePage(),
        'Bottombar':(context)=>BottomBarScreen(),
        'Historypage':(context)=>HistoryPage(),
        'InfoPage':(context)=>InfoScreen(),
        'YoutubeVideoPage':(context)=>Youtubevidepage(),
        'SplashScreen':(context)=>SplashScreenPage(),
        "BlogScreen":(context)=>BlogScreen(),
        "BlogInfoPage":(context)=>BlogInfo(),
     //   InApp.route:(context)=>InApp()
  },
    );
  }
}
