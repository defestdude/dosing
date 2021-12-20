import 'dart:async';
import 'dart:io';
import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:nascp/screens/updater.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path; //used to join paths

class RenderHTML extends StatefulWidget {
  final String touchPoint;
  final String title;


  RenderHTML({Key key, @required this.touchPoint, @required this.title})
      : super(key: key);

  @override
  _RenderHTMLState createState() => _RenderHTMLState(touchPoint, title);
}

class _RenderHTMLState extends State<RenderHTML> {
  String touchPoint;
  String htmlFile;
  String title;
  String htmlFile2 = "https://google.com";
  File realfile;
  String realcontents;
  bool loaded = false;
  _RenderHTMLState(this.touchPoint, this.title); //constructor
  final urlController = TextEditingController();
  

  void initState() {
    super.initState();
    loaders();
    selectHtml();
  }

  void loaders() async {
    await readCounter();
    print("Selected");
  }



  void selectHtml() async {
    switch (touchPoint) {
      case "about":
        {
          htmlFile = "index.html";
        }
        break;
      case "country":
        {
          htmlFile = "country.html";
        }
        break;
      case "targets":
        {
          htmlFile = "targets.html";
        }
        break;
      case "budget":
        {
          htmlFile = "budget.html";
        }
        break;
      case "service":
        {
          htmlFile = "service.html";
        }
        break;
      case "interventions":
        {
          htmlFile = "interventions.html";
        }
        break;

      case "update-summary":
        {
          htmlFile = "update-summary.html";
        }
        break;
      case "hiv_diagnosis":
        {
          htmlFile = "hiv_diagnosis.html";
        }
        break;
      case "first-line":
        {
          htmlFile = "first-line.html";
        }
        break;
      case "second-line":
        {
          htmlFile = "second-line.html";
        }
        break;
      case "pmtct":
        {
          htmlFile = "pmtct.html";
        }
        break;
      case "hiv-prophylaxis":
        {
          htmlFile = "hiv_prophylaxis.html";
        }
        break;
      case "adr":
        {
          htmlFile = "adr.html";
        }
        break;
      case "ahd":
        {
          htmlFile = "ahd.html";
        }
        break;
    }
    var dict1 = await getApplicationDocumentsDirectory();
    var path1 = dict1.path.toString()+'/assets/$htmlFile';
    //var path1 = "/data/user/0/ng.gov.nascp/app_flutter/assets/update-summary.html";
    
    if(!File(path1).existsSync()) {
      print(path1);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Updater(),
        ));

      } else {
        print("found");
      }

  }

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/assets/$htmlFile');
}

Future<String> readCounter() async {
  try {
     this.realfile = await _localFile;
     
     
      final lcontents = await this.realfile.readAsString();
    // Read the file
    setState(() {
          this.realcontents = lcontents;
          this.loaded = true;
        });
     
    // print(this.realcontents);
    return this.realcontents;
  } catch (e) {
    // If encountering an error, return 0
    return "null";
  }
}

  //WebViewPlusController _controller;
  double _height = 2000;

  Matrix4 matrix = Matrix4.identity();
  Matrix4 zerada =  Matrix4.identity();
InAppWebViewController webViewController;
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: loaded == true ? Column(
        children: [
          SizedBox(height: 35),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    )),
                
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.80,
                child: GestureDetector(
                  onDoubleTap: (){
                    setState(() {
                    matrix = zerada;
                  });
                  },
                  child: GestureDetector(
              child: InAppWebView(
                 initialData: InAppWebViewInitialData(
           data: this.realcontents,
          baseUrl: Uri.parse("file://${DownloadAssetsController.assetsDir}index.html"),
        ),
              

                initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            minimumFontSize: 25,
            cacheEnabled: false,
            javaScriptEnabled: true,
            transparentBackground: true,
            verticalScrollBarEnabled: true,
            allowFileAccessFromFileURLs: true,
            allowUniversalAccessFromFileURLs: true,
            clearCache: true,
          ),
          android: AndroidInAppWebViewOptions(useHybridComposition: true),
          ios: IOSInAppWebViewOptions(
            allowingReadAccessTo: Uri.parse("file://${DownloadAssetsController.assetsDir}index.html"),
          ),
        ),
                onWebViewCreated: (InAppWebViewController controller) {
                  webViewController = controller;
                  //webViewController.loadFile(assetFilePath: DownloadAssetsController.assetsDir);
                },
                onLoadStart: (controller, url) {
                      setState(() {
                        
                        urlController.text = htmlFile;
                      });
                    },
              ),
             
        
                  ),
                ),
              ),
            ),
          )
        ],
      ) :  Center(child: CircularProgressIndicator(),),
    ) ;
  }
}
