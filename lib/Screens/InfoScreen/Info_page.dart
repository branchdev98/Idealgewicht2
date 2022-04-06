import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vtm/Config/Constants.dart';
import 'package:vtm/Screens/Global_File/GlobalFile.dart';

class InfoScreen extends StatefulWidget {

  VoidCallback refreshScreen;


  InfoScreen({this.refreshScreen});

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {


  int SelectedIndex=2;

  List<String> Title =[aboutTitleText,stereotiefensuggestionTitleText,neuesTitleText];
  List<String> myList =[
   aboutDescText,
    stereotiefensuggestionDescText,
    neuesDescText
  ] ;



  @override
  Widget build(BuildContext context) {


    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(refresh: widget.refreshScreen,),
     // bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(text: menuTitleMoreInformation??"More Information",addiconclr: Colors.transparent,
            menuiconclr: VtmBlue,
              clickonmenuicon: (){
                print("clicked");
                _scaffoldKey.currentState.openDrawer();
              },),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 15, 00),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(color: VtmWhite,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [BoxShadow(color: Colors.black12,blurRadius: 20,offset: Offset(00, 00))]
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.all(20)
                            ,child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(Title[SelectedIndex],
                                        style: TextStyle(fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                          color: VtmBlue,
                                          fontFamily: 'Montserrat-Regular'
                                        ),),
                                        /*Text("Tiefensuggetion",style: TextStyle(
                                          color: VtmGrey,fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                            fontFamily: 'Montserrat-Medium'
                                        ),)*/
                                      ],
                                    ),
                                    Spacer(),
                                    SelectedIndex==0?Container(
                                        width: MediaQuery.of(context).size.width*0.17,
                                        height:MediaQuery.of(context).size.height*0.10,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new AssetImage('assets/images/user.jpeg')
                                            )
                                        )):SizedBox(),
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Expanded(
                                  child: Scrollbar(
                                    child: new SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      //.horizontal
                                      child: new Text(

                              myList[SelectedIndex],
                                        textAlign: TextAlign.left,style: new TextStyle(
                                          fontSize: 14.0,
                                            fontFamily: 'Montserrat-Light',

                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Text("Information",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,color: VtmBlue
                    ),),
                    SizedBox(height: 10,),
                    MyInfoTile(title: neuesTitleText??"Neues",onPressed: (){ setIndex(2);},selected: SelectedIndex==2,),
                    MyInfoTile(title: stereotiefensuggestionTitleText??"Stereotiefensuggestion",onPressed: (){ setIndex(1);},selected: SelectedIndex==1,),

                    MyInfoTile(title: aboutTitleText??"About",onPressed:(){ setIndex(0);},selected: SelectedIndex==0,),
                    SizedBox(height: 25,),


                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  setIndex(int i){
    SelectedIndex=i;
    setState(() {

    });
  }

}


class MyInfoTile extends StatelessWidget {
  final String infoReadImage = 'assets/images/inforead.svg';
  String title;
  VoidCallback onPressed;
  bool selected;

  MyInfoTile({this.title, this.onPressed,this.selected});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap:
        onPressed??(){}
      ,
      child: Column(
        children: [
          Container(
            color: selected?VtmInActiveColor:Colors.transparent,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                  child: Column(
                    children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("$title",style: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 16,
                            color: VtmBlue,
                          ),),
                         Spacer(),
                          SvgPicture.asset(
                            infoReadImage,
                            color: VtmBlue,
                            height: MediaQuery.of(context).size.width * 0.05,
                            width: MediaQuery.of(context).size.width * 0.05,
                          ),
                         /* SizedBox(
                            width: 15,
                          ),
                          Text("2 - min",style: TextStyle(
                              fontFamily: 'Montserrat-Regular',
                              fontSize: 16,
                            color: selected?VtmBlue:VtmGrey,
                          ),)*/
                        ],
                      ),

                    ],
                  ),
                ),
                Container(height: 1,color: Colors.grey,)

              ],
            ),
          ),

        ],
      ),
    );
  }
}
