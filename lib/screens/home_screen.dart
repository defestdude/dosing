import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nascp/constants.dart';
import 'package:nascp/screens/book_details.dart';
import 'package:nascp/screens/book_read.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/hiv_treatment.dart';
import 'package:nascp/screens/national_acceleration.dart';
import 'package:nascp/widgets/book_rating.dart';
import 'package:nascp/widgets/policies_card.dart';
import 'package:nascp/widgets/policies_card_2.dart';
import 'package:nascp/widgets/policies_card_3.dart';
import 'package:nascp/widgets/two_side_rounded_button.dart';
import 'package:download_assets/download_assets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  DownloadAssetsController downloadAssetsController = DownloadAssetsController();
    final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  double _progress = 0;

  bool isDrawerOpen = false;
  String message;
  bool downloaded;
  bool downloading = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    
   super.initState();
   loaders();
    
  }

  void loaders() async{
    await downloadAssetsController.init();
  }

  Future getpath() async {
    print("doing");
    Directory directory = await getApplicationDocumentsDirectory();
    print("main "+directory.path);
    print("none\n");
    print("controller " +downloadAssetsController.assetsDir);

    //getpath();
  }


final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context){
   // getpath();
    var size = MediaQuery.of(context).size;
    return  Scaffold(
      key: _scaffoldKey,    
      drawer: DrawerScreen(),
            body: SmartRefresher(
              enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(),
        controller: _refreshController,
        onRefresh: () async {
         
          _refreshController.refreshCompleted();
           await downloadAssetsController.clearAssets();
          await _downloadAssets();
        },
              child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(image: DecorationImage(
                      image: AssetImage("assets/images/main_bg.png"),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                    children: <Widget> [
                      SizedBox(height: 70),         
                    ]
                  ),
                  IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                 _scaffoldKey.currentState.openDrawer();
              }),
                 
                        SizedBox(height: size.height * .01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF0C8863),
                                        fontFamily: "Trueno",
                                        fontWeight: FontWeight.w500,
                                      ),
                              children: [
                                TextSpan(text: "Featured", )
                              ]
                            )
                          ),
                        ),
                        SizedBox(height: 10),
                         downloading == true ? 
                         Padding(
                           padding: const EdgeInsets.all(13.0),
                           child: Container(                      
                             child: Row(     
                               children: [
                              Expanded(child: RichText(text: TextSpan(style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[400],
                                        fontFamily: "Trueno",
                                        fontWeight: FontWeight.w500,
                                      ),text: "Downloading Updates"))),
                                 Expanded(
                                   child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[400],
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF0C8863)),
                  value: _progress,
                ),
                                 ),
                               ],
                             ),
                           ),
                         ) : 
                SizedBox(height:0),
                        Padding(padding: EdgeInsets.symmetric(horizontal:24),
                        child: Row(
                        
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var offset = _controller.offset; 
                                setState(() {
                                   _controller.animateTo(offset - 100,
                                  duration: Duration(milliseconds: 200), curve: Curves.ease);
                                });
                              },
                              child: Icon(Icons.arrow_left, size: 50,color: Color(0xFF549d84),
                          ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                var offset = _controller.offset; 
                                setState(() {
                                   _controller.animateTo(offset + 100,
                                  duration: Duration(milliseconds: 200), curve: Curves.ease);
                                });
                              },
                              child: Icon(Icons.arrow_right, size: 50,color: Color(0xFF549d84),
                          ),
                            ),
                          ],
                        ),),
                        SingleChildScrollView(
                          controller: _controller,
                          scrollDirection: Axis.horizontal,
                                      child: Row(
                            children: <Widget>[
                              GestureDetector(
                                 onTap: () {
                              
                            setState((){Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HIVTreatment();
                                        }
                                      )
                                    );});
                                 },
                                  child: PoliciesCard3(
                                  image: "assets/images/book_2.png",
                                  title: "National Guideline for \n",
                                  auth: "HIV Prevention Treatment and Care",
                                  rating: 4.9,
                                  pressRead: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookRead(2, "National Guideline for HIV Prevention Treatment and Care");
                                        }
                                      )
                                    );
                                  },
                                  pressDetails: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookRead(2, "National Guideline for HIV Prevention Treatment and Care");
                                        }
                                      )
                                    );
                                  }
                              ),
                               ),
                              GestureDetector(
                                onTap: () {
                                               
                            setState((){Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NationalAcceleration();
                                        }
                                      )
                                    );});
                                },
                                  child: PoliciesCard(
                                  image: "assets/images/book_1.png",
                                  title: "National Acceleration Plan\n",
                                  auth: "for Pediatric and Adeoescent HIV Treatment & Care",
                                  rating: 4.9,
                                  pressRead: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookRead(1, "National Acceleration Plan for Pediatric and Adeoescent HIV Treatment & Care");
                                        }
                                      )
                                    );
                                  },
                                  pressDetails: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookRead(1, "National Acceleration Plan for Pediatric and Adeoescent HIV Treatment & Care");
                                        }
                                      )
                                    );
                                  }
                                ),
                              ),
                               GestureDetector(
                                onTap: () {
                             
                            
                            setState((){Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookRead(4, "2019 HIV Health Sector Annual Report");
                                        }
                                      )
                                    );});
                                },
                                  child: PoliciesCard2(
                                  image: "assets/images/book_4.png",
                                  title: "2019 HIV Health Sector\n",
                                  auth: "Annual Report",
                                  rating: 4.9,
                                  pressRead: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookRead(4, "2019 HIV Health Sector Annual Report");
                                        }
                                      )
                                    );
                                  },
                                  pressDetails: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return BookRead(4, "2019 HIV Health Sector Annual Report");
                                        }
                                      )
                                    );
                                  }
                                ),
                              ),
                               
                               
                              SizedBox(width: 30)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.headline4,
                                  children: [
                                    TextSpan(text: "Other Resources",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0xFF0C8863),
                                        fontFamily: "Trueno",
                                        fontWeight: FontWeight.w500,
                                      ),)
                                  ]
                                )
                              ),
                              mostReadCard(size, context),
                              mostReadCard2(size, context),
                            
                            ]
                          )
                        )
                      ]
                    )
                  ),
                ],
              ),
              ),
            )
          
          
        
      
          );
  }

  Container mostReadCard(Size size, BuildContext context) {
    return Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 195,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(left:24, top: 24, right: size.width * .35),
                          height: 185,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFEAEAEA).withOpacity(.45),
                            borderRadius: BorderRadius.circular(29),
                            ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("National Guideline for HIV Prevention Treatment and Care",
                              style: TextStyle(fontSize: 9,
                              color: kLightBlackColor
                              )
                              ),
                              SizedBox(height: 5),
                              Text("HIV Treatment Guidelines",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                              ),
                              Text("2016",
                              style: TextStyle(
                                color: kLightBlackColor
                              )
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                 
                                  SizedBox(width: 10),
                                  Expanded(child: Text(
                                    "The Government of Nigeria is deeply committed to providing high quality and comprehensive care for its population of people living with HIV/AIDS.",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: kLightBlackColor
                                    )
                                    ))
                                ]
                              )
                            ]
                          )
                        )
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Image.asset("assets/images/book_3.png",
                        width: size.width * .27)
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                        height: 40,
                        width: size.width * .3,
                        child: TwoSideRoundedButton(
                          text: "Download",
                          radius: 24,
                        
                          press: () { Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BookRead(3, "National Guideline for HIV Prevention Treatment and Care");
                                      }
                                    )
                                  );}
                        )
                      ))
                    ]
                  )
                );
  }


  Container mostReadCard2(Size size, BuildContext context) {
    return Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 195,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.only(left:24, top: 24, right: size.width * .35),
                          height: 185,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xFFEAEAEA).withOpacity(.45),
                            borderRadius: BorderRadius.circular(29),
                            ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("NASCP",
                              style: TextStyle(fontSize: 9,
                              color: kLightBlackColor
                              )
                              ),
                              SizedBox(height: 5),
                              Text("HIV Health Sector Annual Report",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                              ),
                              Text("2018",
                              style: TextStyle(
                                color: kLightBlackColor
                              )
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                 
                                  SizedBox(width: 10),
                                  Expanded(child: Text(
                                    "Nigeria remains committed to meeting the vision to halt and reverse the HIV and AIDS epidemic in the country and promote the achievements of HIV/AIDS prevention",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: kLightBlackColor
                                    )
                                    ))
                                ]
                              )
                            ]
                          )
                        )
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Image.asset("assets/images/book_5.png",
                        width: size.width * .27)
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                        height: 40,
                        width: size.width * .3,
                        child: TwoSideRoundedButton(
                          text: "Download",
                          radius: 24,
                        
                          press: () { Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return BookRead(5, "2018 HIV Health Sector Annual Report");
                                      }
                                    )
                                  );}
                        )
                      ))
                    ]
                  )
                );
  }



  Future _downloadAssets() async {
    bool assetsDownloaded = await downloadAssetsController.assetsDirAlreadyExists();

   /*if (assetsDownloaded) {
      setState(() {
        message = "Click in refresh button to force download";
        print(message);
      });
      return;
    }*/
    print("trying");
    try {
      await downloadAssetsController.startDownload(
          assetsUrl: "https://nascp.gov.ng/assets/touchpoints.zip",
          onProgress: (progressValue) {
            downloaded = false;
            
            setState(() {
              message = "Downloading - ${progressValue.toStringAsFixed(2)}";
              _progress = progressValue / 100;
              downloading = true;
              if (progressValue < 100) {
                message = "Downloading - ${progressValue.toStringAsFixed(2)}";
                print(message);
            } else {
              message = "Download completed\nClick in refresh button to force download";
              print(message);
              downloaded = true;
              downloading = false;
            }
            });
          },
      );
    }  on DownloadAssetsException catch (e) {
      print(e.toString());
      setState(() {
        downloaded = false;
        message = "Error: ${e.toString()}";
      });
    }
  
}

}

