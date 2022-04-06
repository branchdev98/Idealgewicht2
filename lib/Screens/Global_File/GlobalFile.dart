import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Models/Channel_Model.dart';
import 'package:vtm/Models/Posts.dart';
import 'package:vtm/Models/Video_Model.dart';
import 'package:vtm/Screens/MusicPlayer_Home/VtmHome.dart';


const VtmBlue = Color(0xff2a398a);
const VtmGrey = Colors.grey;
const VtmLightBlue = Colors.lightBlueAccent;
const VtmWhite = Colors.white;
const VtmRed = Colors.red;
const VtmBlack = Colors.black;
const keysBackground = Color(0xffc5d5ee);
const VtmInActiveColor  = Color(0xff727cc5);

class Global {
  static int currentPageIndex = 1;
  static double iconSize = 0.07;
  static double dairyIconSize = 0.05;
  static bool fullScreenPlayer=false;
 /* static wp.Post currentSelectedPost;
  static Future<List<wp.Post>> myPOSTs;*/
  static List<Posts> allPosts=[];
  static Posts currentPost;
  static User user ;

  static Channel channel;
  static List<Video> allVideos;

}

class CustomAppBar extends StatelessWidget {
  final String text;
  final bool isMore;
  final Color addiconclr;
  final Color menuiconclr;
  final VoidCallback clickonmenuicon;
  final VoidCallback clickonmoreicon;
  final bool back;
  final VoidCallback onBack;

  final String addImage = 'assets/images/more.svg';
  final String backButton =  'assets/images/backbutton.svg';
  final String menuImage = 'assets/images/menu.svg';

  CustomAppBar(
      {this.text,
      this.isMore,
      this.addiconclr,
      this.menuiconclr,
      this.clickonmenuicon,
      this.clickonmoreicon,this.back,this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(25,20,25,0),
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.width * 0.06,
                    width: MediaQuery.of(context).size.width * 0.06,
                    child: GestureDetector(
                        onTap: onBack??clickonmenuicon,
                        child: SvgPicture.asset(
                          onBack==null?menuImage:backButton,
                          color: menuiconclr,
                        ))),
                Spacer(),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.05,
                      color: VtmBlue,
                      //fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Black'),
                ),
                Spacer(),
                GestureDetector(
                  onTap: clickonmoreicon,
                  child: SvgPicture.asset(
                    addImage,
                    height: MediaQuery.of(context).size.width * 0.06,
                    width: MediaQuery.of(context).size.width * 0.06,
                    color: addiconclr,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

final String playerImage = 'assets/images/player.svg';
final String infoImage = 'assets/images/info.svg';
final String historyImage = 'assets/images/history.svg';
final String videoImage = 'assets/images/youtube.svg';
final String moreImage = 'assets/images/menu.svg';
final String legalImage = 'assets/images/legal.svg';
final String moreInfo = 'assets/images/moreinfo.svg';
final String eula = 'assets/images/eula.svg';

class CustomBottomBar extends StatefulWidget {
  final VoidCallback click;

  CustomBottomBar({this.click});

  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            new BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 5,
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Global.currentPageIndex = 1;
                  // Navigator.of(context).pushReplacementNamed('Musicplayer_VtmHome');
                  setState(() {});
                  widget.click();
                },
                child: SvgPicture.asset(
                  'assets/images/player.svg',
                  color: Global.currentPageIndex == 1 ? VtmBlue : VtmGrey,
                  height: MediaQuery.of(context).size.width * Global.iconSize,
                  width: MediaQuery.of(context).size.width * Global.iconSize,
                  fit: BoxFit.contain,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print(Global.currentPageIndex);
                  Global.currentPageIndex = 0;
                  // Navigator.of(context).pushReplacementNamed('InfoPage');
                  setState(() {});
                  widget.click();
                },
                child: SvgPicture.asset(
                  'assets/images/info.svg',
                  color: Global.currentPageIndex == 0 ? VtmBlue : VtmGrey,
                  height: MediaQuery.of(context).size.width * Global.iconSize,
                  width: MediaQuery.of(context).size.width * Global.iconSize,
                  fit: BoxFit.contain,
                ),
              ),
              /*Spacer(),*/
              GestureDetector(
                onTap: () {
                  Global.currentPageIndex = 3;
                  // Navigator.of(context).pushReplacementNamed('HistoryPage');
                  setState(() {});
                  widget.click();
                },
                child: SvgPicture.asset(
                  'assets/images/history.svg',
                  color: Global.currentPageIndex == 3 ? VtmBlue : VtmGrey,
                  height: MediaQuery.of(context).size.width * Global.iconSize,
                  width: MediaQuery.of(context).size.width * Global.iconSize,
                  fit: BoxFit.contain,
                ),
              ),
              /*Spacer(),*/
              GestureDetector(
                onTap: () {
                  Global.currentPageIndex = 2;
                  // Navigator.of(context).pushReplacementNamed('YoutubeVideoPage');
                  setState(() {});
                  widget.click();
                },
                child: SvgPicture.asset(
                  'assets/images/youtube.svg',
                  color: Global.currentPageIndex == 2 ? VtmBlue : VtmGrey,
                  height: MediaQuery.of(context).size.width * Global.iconSize,
                  width: MediaQuery.of(context).size.width * Global.iconSize,
                  fit: BoxFit.contain,
                ),
              ),
              /*Spacer(),*/
              /*Spacer(),*/
              GestureDetector(
                onTap: () {
                  Global.currentPageIndex = 4;
                  //Navigator.of(context).pushReplacementNamed('Musicplayer_VtmHome');
                  setState(() {});
                  widget.click();
                },
                child: SvgPicture.asset(
                  moreInfo,
                  color: Global.currentPageIndex == 4 ||Global.currentPageIndex == 5 ? VtmBlue:VtmGrey,
                  height: MediaQuery.of(context).size.width * Global.iconSize,
                  width: MediaQuery.of(context).size.width * Global.iconSize,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Drawer
class CustomDrawer extends StatelessWidget {

  VoidCallback refresh;


  CustomDrawer({this.refresh});

  @override
  Widget build(BuildContext context) {

    double gapBetweenTiles = MediaQuery.of(context).size.width*0.08;

    Legaldialog(BuildContext context) async {

      return showDialog(

          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                children: [
                  Opacity(
                    opacity: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel,color: VtmBlue,size: MediaQuery.of(context).size.width*0.06,),
                    ),
                  ),
                  Expanded(child: Center(child: Text(mainMenulegalTitleText??'Legal'))),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.cancel,color: VtmBlue,size: MediaQuery.of(context).size.width*0.06,),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))
              ),
              content: Container(
                decoration: BoxDecoration(
                  //color: VtmLightBlue.withOpacity(0.2),

                    borderRadius:
                    BorderRadius.all(Radius.circular(40))),
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(color: VtmGrey.withOpacity(0.9),thickness: 1,),
                    SizedBox(
                      height: 10,
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(legalDescText??" "),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),


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
    return Container(
      width: MediaQuery.of(context).size.width * 0.55,
      child: Drawer(
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              ListTile(onTap: (){

                Global.currentPageIndex = 1;
                refresh();
              },
                contentPadding:
                EdgeInsets.only(left: 0, right: 0, bottom: 0, top: 0),
                title: Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.width * 0.3,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage("assets/images/bgForPlayer.png"),
                              fit: BoxFit.cover,
                            ))),
                    SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      height: 3,
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25, 15, 15, 0),
                child: Column(
                  children: [
                    GestureDetector(onTap: (){
                      Global.currentPageIndex = 1;
                      refresh();
                    },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            playerImage,
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            mainMenuPlayerText??'Player',
                            style: TextStyle(
                                fontFamily: 'MontserratSubrayada-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width*0.04),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: gapBetweenTiles,
                      thickness: 1,
                    ),
                    GestureDetector(onTap: (){
                      Global.currentPageIndex = 0;
                      refresh();
                    },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            infoImage,
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            mainMenuInfosText??'Infos',
                            style: TextStyle(
                                fontFamily: 'MontserratSubrayada-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width*0.04),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: gapBetweenTiles,
                      thickness: 1,
                    ),
                    GestureDetector(onTap: (){
                      Global.currentPageIndex = 3;
                      refresh();
                    },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            historyImage,
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            mainMenuHistoryText??'History',
                            style: TextStyle(
                                fontFamily: 'MontserratSubrayada-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width*0.04),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: gapBetweenTiles,
                      thickness: 1,
                    ),
                    GestureDetector(onTap: (){
                      Global.currentPageIndex = 2;
                      refresh();
                    },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            videoImage,
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            mainMenuVideosText??'Videos',
                            style: TextStyle(
                                fontFamily: 'MontserratSubrayada-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width*0.04),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: gapBetweenTiles,
                      thickness: 1,
                    ),
                    GestureDetector(onTap: (){
                      Global.currentPageIndex = 4;
                      refresh();
                    },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            moreInfo,
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            mainMenuMoreText??'More',
                            style: TextStyle(
                                fontFamily: 'MontserratSubrayada-Bold',
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width*0.04),
                          ),
                        ],
                      ),
                    ),
             /*       Divider(
                      height: gapBetweenTiles,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: () async {

                        const url = 'http://blog.vtm-stein.de/agbs-app-nutzung/';
                        if (await canLaunch(url)) {
                        await launch(url);
                        } else {
                        throw 'Could not launch $url';
                        }

                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            eula,
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              EULA??'Legal',
                              style: TextStyle(
                                  fontFamily: 'MontserratSubrayada-Bold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width*0.04),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    Divider(
                      height: gapBetweenTiles,
                      thickness: 1,
                    ),
                    GestureDetector(
                      onTap: (){

                        Legaldialog(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            legalImage,
                            height: MediaQuery.of(context).size.height * 0.025,
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              mainMenulegalTitleText??'Legal',
                              style: TextStyle(
                                  fontFamily: 'MontserratSubrayada-Bold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width*0.04),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Show_toast_Now(String msg,Color color){
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb	: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}