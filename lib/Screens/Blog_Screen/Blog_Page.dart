import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Models/Posts.dart';
import 'package:vtm/Screens/Blog_Screen/Blog_InfoPage.dart';
import 'package:vtm/Screens/Global_File/GlobalFile.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:flutter_launcher_icons/constants.dart';



class BlogScreen extends StatefulWidget {
  VoidCallback refreshScreen;

  BlogScreen({this.refreshScreen});

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {



@override
  void initState() {
    // TODO: implement initState

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold( key: _scaffoldKey,
      drawer: CustomDrawer(refresh: widget.refreshScreen,),
      //bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(menuiconclr: VtmBlue,
            text: MoreTitle??"MORE",
             addiconclr: Colors.transparent,
              clickonmenuicon: (){
                print("clicked");
                _scaffoldKey.currentState.openDrawer();
              },),
            SizedBox(height: 5,),
            Expanded(
              child: ListView.builder(
                  itemCount:Global.allPosts.length,
                  itemBuilder: (BuildContext ctxt, int index) {

                    return MiniBlogTile(post: Global.allPosts[index],refreshScreen: widget.refreshScreen,);
                  })
            ),

          ],
        ),
      ),
    );
  }
}

class MiniBlogTile extends StatelessWidget {
  Posts post;
  VoidCallback refreshScreen;
  MiniBlogTile({this.post,this.refreshScreen});

  final String imagename = 'assets/images/logo.svg';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0,0,4,0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width*.25,
            child: Card(
              child: InkWell(
                onTap: (){
                  Global.currentPost=post;
                  Global.currentPageIndex=5;
                  refreshScreen();

                },
                splashColor: VtmLightBlue,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      post.jetpackFeaturedMediaUrl!=""?ClipRRect(borderRadius: BorderRadius.circular(4),
                          child: Image.network(post.jetpackFeaturedMediaUrl,height:MediaQuery.of(context).size.width*.25,width: MediaQuery.of(context).size.width*.3,fit: BoxFit.cover ,)):
                      Container(

    height:MediaQuery.of(context).size.width*.25,width: MediaQuery.of(context).size.width*.3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(imagename,color: VtmBlue,),
                        ),
                      ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(post.title.rendered.toString().length<26?post.title.rendered.toString():post.title.rendered.toString().substring(0,26)+"...",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:MediaQuery.of(context).size.width*0.04,
                                        fontFamily: 'Montserrat-Regular',
                                      color: VtmBlue

                                    ),),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(post.author.toString(),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width*0.000,
                                        fontFamily: 'Montserrat-Regular'
                                    ),),
                                  SizedBox(
                                    height: 5,
                                  ),
Spacer(),
                                  Row(
                                    children: [

                                      Text(
                                       readMore??"READ MORE",
                                        style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.035,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Montserrat-Regular'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}

