import 'dart:ffi';

import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/home_screen.dart';
import 'package:path_provider/path_provider.dart';



class Updater extends StatefulWidget {
  @override
  _UpdaterState createState() => _UpdaterState();
}

class _UpdaterState extends State<Updater> {
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 
  double _download_progress = 0.6;
  String message;
  bool downloaded;
  bool downloading = false;
  String percentage = "";
  double _progress = 0;

  void initState() {
    super.initState();
    loaders();
  }

  void loaders() async {
    await _downloadAssets();
    print("Started");
  }

    @override
  Widget build(BuildContext context) {
     final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Scaffold(
       key: _scaffoldKey,    
      drawer: DrawerScreen(),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child:  _buildUpdater()));
  }

  _buildUpdater() {
     final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          
            Container(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                   _scaffoldKey.currentState.openDrawer();
                }),
            ),
           
          SizedBox(height: 65.0),
         
          Container(
              height: 125.0,
              width: 200.0,
              child: Stack(
                children: [
                            
                  Text('Updater',
                      style: TextStyle(fontFamily: 'Trueno', fontSize: 60.0)),
               
                  Positioned(
                      top: 97.0,
                      left: 0.0,
                      child: Row(
                        children: [
                          Icon(Icons.download_outlined),
                          Text("$percentage %")
                        ],
                      ))
                ],
              )),
          SizedBox(height: 25.0),
           Text('There are important updates to the documents and data. Please wait for the download to complete..', style: TextStyle(fontFamily: 'Trueno', fontWeight: FontWeight.w500)),
           SizedBox(height: 25.0),
          LinearProgressIndicator(
                  backgroundColor: Colors.grey[400],
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF0C8863)),
                  value: _progress,
                  minHeight: 20,
                  
                ),
 
        ]));
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }



  Future _downloadAssets() async {
    bool assetsDownloaded = await DownloadAssetsController.assetsDirAlreadyExists();
    //print("trying");
    //await _deleteCacheDir();
    await DownloadAssetsController.clearAssets();
    try {
      await DownloadAssetsController.startDownload(
        
          assetsUrl: "https://nascp.gov.ng/assets/touchpoints.zip",
          onProgress: (progressValue) {
            downloaded = false;
            
            setState(() {
              message = "Downloading - ${progressValue.toStringAsFixed(2)}";
              percentage = progressValue.toStringAsFixed(2);
              _progress = progressValue / 100;
              downloading = true;
            });
          },
          onComplete: () {
            setState(() {
              message = "Download compeleted\nClick in refresh button to force download";
              downloaded = true;
              downloading = false;
              /* Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => HomeScreen()
     
              ));*/
             // print(message);
             
              Navigator.pushNamedAndRemoveUntil(context,'/',(_) => false);
            });
          },
          onError: (exception) {
            setState(() {
              downloaded = false;
              message = "Error: ${exception.toString()}";
              print(message);
            });
          }
      );
    } on DownloadAssetsException catch (e) {
      print(e.toString());
    }
  
}
}