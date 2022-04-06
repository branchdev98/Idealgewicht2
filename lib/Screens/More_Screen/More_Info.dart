import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Screens/Global_File/GlobalFile.dart';

import 'package:assets_audio_player/assets_audio_player.dart';


class MorePage extends StatefulWidget {
  VoidCallback refreshScreen;

  MorePage({this.refreshScreen});

  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey =
    new GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(title: Text(MoreTitle??"More"),),
      key: _scaffoldKey,
      drawer: CustomDrawer(
        refresh: widget.refreshScreen,
      ),
      //bottomNavigationBar: CustomBottomBar(),
      body: Container(
        child: Column(
          children: <Widget>[

            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (BuildContext ctxt, int Index){
                    return Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Card(
                        color: VtmBlue,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                              child: Row(
                                children: <Widget>[
                                  Text("Title of Blogpost",style: TextStyle(
                                    color: VtmWhite,fontSize: 18,fontWeight: FontWeight.w500
                                  ),),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                  child: Image.asset("assets/images/bgofmusic.jpeg",
                                    scale: 5,)),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10,bottom: 10,right: 15),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text("Lorem ipsum, or lipsum as it is "
                                        "sometimes known, is dummy text used in "
                                        "laying out print, graphic or web designs. "
                                        "The passage is attributed to an unknown typesetter "
                                        "in the 15th century who is thought to have "
                                        "scrambled parts of Cicero's De Finibus Bonorum "
                                        "et Malorum for use in a type specimen book.",style: TextStyle(
                                        color: VtmWhite,fontSize: 18,fontWeight: FontWeight.w500,
                                    ),textAlign: TextAlign.justify,),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10,top: 10),
                              child: Container(
                                height: 50,
                                child: Card(
                                  color: VtmWhite,
                                  child: Row(
                                    children: <Widget>[
                                      Spacer(),
                                      Icon(Icons.more_horiz),
                                      SizedBox(width: 10,),
                                      Icon(Icons.share),
                                      SizedBox(width: 15,),

                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
