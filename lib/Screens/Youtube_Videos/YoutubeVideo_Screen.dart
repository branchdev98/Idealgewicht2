import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Screens/Global_File/GlobalFile.dart';
import 'package:vtm/Models/Channel_Model.dart';
import 'package:vtm/Models/Video_Model.dart';
import 'package:vtm/Screens/Play_Video.dart';
import 'package:vtm/Services/Api_Services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:io';

class Youtubevidepage extends StatefulWidget {
  VoidCallback refreshScreen;
  Youtubevidepage({this.refreshScreen});

  @override
  _YoutubevidepageState createState() => _YoutubevidepageState();
}

class _YoutubevidepageState extends State<Youtubevidepage> {

  //api key:AIzaSyAAk_8rXF2rK_Mll3Hhi50UYjUEMzZLZtM

  String currentVideoTitle="";
  String videoID;
  YoutubePlayerController _controller = new YoutubePlayerController(initialVideoId: "fFvhnB_2MYM" ,flags: YoutubePlayerFlags(
    autoPlay: true,
    mute: true,
  ),);
  Channel _channel;
  bool _isLoading = false;
  double CurrentValue=0;
  bool playerReady=false;

  var _wifiEnabled;


  _launchURL() async {
    const url = 'https://www.youtube.com/playlist?list=PL30UNi-swIZidMWsNyWster0B4UhiDmQ_';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  test()async{
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        _wifiEnabled = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      _wifiEnabled = false;
      Show_toast_Now(noInterNet??"No Internet Connection", Colors.red);
    }
  }

  @override
  void initState() {
    test();
    _initChannel();
    super.initState();

  }

  _initYoutubePlayer(){
    _controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    setState(() {

    });
  }

  _initChannel() async {

    if(Global.channel==null) {
      Channel channel = await APIService.instance
          .fetchChannel(channelId: 'UCjEn6jqeMuCZzJJGfE-vLsg');
      setState(() {
        _channel = channel;
      });
    }
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(15.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doctorCompanyName??"VTM Dr. Stein",
                  style: TextStyle(
                    color: VtmBlue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10,),
              GestureDetector(
                onTap: (){
                  _launchURL();
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/link.svg',
                      color: Global.currentPageIndex == 1 ? VtmBlue : VtmGrey,
                      height: MediaQuery.of(context).size.width * Global.iconSize-10,
                      width: MediaQuery.of(context).size.width * Global.iconSize-10,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10,),

                    Expanded(
                      child: Text(
                          visitOurYoutubeChannel??'Visit our youtube channel',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                    ),
                  ],
                ),
              ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
      child: GestureDetector(
        onTap: (){

          videoID=video.id;
          currentVideoTitle = video.title;
          _initYoutubePlayer();

        //   Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => VideoScreen(id: video.id),
        //   ),
        // );
        },
        child: Container(
          //margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),

          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 0),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image(

                height: MediaQuery.of(context).size.width*0.25,
                image: NetworkImage(video.thumbnailUrl),
              ),

              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        video.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat-Regular',
                          fontSize: 14.0,
                        ),
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

  _loadMoreVideos() async {


      _isLoading = true;
      List<Video> moreVideos = await APIService.instance.fetchVideosFromPlaylist(playlistId: "PL30UNi-swIZidMWsNyWster0B4UhiDmQ_");
      List<Video> allVideos = _channel.videos..addAll(moreVideos);
      setState(() {
        _channel.videos = allVideos;
      });
      _isLoading = false;

  }

  /*YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'VTMStein',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );*/

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Global.fullScreenPlayer?Colors.black:Colors.white,
      key: _scaffoldKey,
      drawer: CustomDrawer(
        refresh: widget.refreshScreen,
      ),
      //bottomNavigationBar: CustomBottomBar(),

      body: YoutubePlayerBuilder(
     player:   YoutubePlayer(
        width: MediaQuery.of(context).size.width,
        aspectRatio:2.0,
        controller: _controller,
        onReady: () {

          print("Player is Ready");
          Future.delayed(Duration(seconds: 2),(){
            print("Pklayion avidsafo");
            _controller.play();
          }
          );

        },

      ),builder: (context,player){
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: SafeArea(
              child: Column(
                children: [
                  CustomAppBar(
                    text: videosTitle??"VIDEOS",
                    menuiconclr: VtmBlue,
                    addiconclr: Colors.transparent,
                    clickonmenuicon: () {
                      print("clicked");
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  videoID!=null && !Global.fullScreenPlayer?Column(
                    children: [
                    player,
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(currentVideoTitle,style: TextStyle(fontWeight: FontWeight.bold,color: VtmBlue),),
                      )
                    ],
                  ):SizedBox(),
                  _channel != null
                      ? NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollDetails) {
                      if (!_isLoading &&
                          _channel.videos.length != int.parse(_channel.videoCount) &&
                          scrollDetails.metrics.pixels ==
                              scrollDetails.metrics.maxScrollExtent) {

                          _loadMoreVideos();

                      }
                      return false;
                    },
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: (1 + _channel.videos.length)<6?(1 + _channel.videos.length):6,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return _buildProfileInfo();
                          }
                          Video video = _channel.videos[index - 1];
                          return _buildVideo(video);
                        },
                      ),
                    ),
                  )
                      : Expanded(
                        child: Center(
                    child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor, // Red
                        ),
                    ),
                  ),
                      ),

                ],
              ),
            ),
          ),
        );
      },),
    );
  }
}
