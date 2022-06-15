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
  DownloadAssetsController downloadAssetsController = DownloadAssetsController();
  String touchPoint;
  String htmlFile;
  String title;
  String htmlFile2 = "https://google.com";
  File realfile;
  String realcontents;
  bool loaded = false;
  String maindir = "";
  String mainfile = "";
  _RenderHTMLState(this.touchPoint, this.title); //constructor
  final urlController = TextEditingController();
  

  void initState() {
    super.initState();
    loaders();
    selectHtml();
  }

  void loaders() async {
    await readCounter();
    await downloadAssetsController.init();
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
    await downloadAssetsController.init();
    var dict1 = downloadAssetsController.assetsDir;
    //var dict1 = await getApplicationDocumentsDirectory();
   // var path1 = Path.join(dict1, "/$htmlFile");
    var path1 = dict1+'/$htmlFile';
    //var path1 = "/data/user/0/ng.gov.nascp/app_flutter/assets/update-summary.html";
    print(path1);
   
    
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
  await downloadAssetsController.init();
  final directory = downloadAssetsController.assetsDir;
  maindir = directory;
  //final directory = await getApplicationDocumentsDirectory();
  return directory;
}

Future<File> get _localFile async {
  final path = await _localPath;
  
  //return File(Path.join(path, "/assets/$htmlFile"));
  mainfile = "$path/$htmlFile";
  return File('$path/$htmlFile');
}

Future<String> readCounter() async {
  try {
      this.realfile = await _localFile;
    
      String tmpcontents = await this.realfile.readAsString();
     
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
    print(mainfile);
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
                //initialFile: "file://${mainfile}",
                  // initialData: InAppWebViewInitialData(
                  // data: this.realcontents,

                  // ),
                  initialUrlRequest: URLRequest(url: Uri.parse("file://${mainfile}")),


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
                    android: AndroidInAppWebViewOptions(
                      useHybridComposition: true,
                      allowFileAccess: true,
                    ),
                    ios: IOSInAppWebViewOptions(
                      allowingReadAccessTo: Uri.parse("file:///Users/donaldmkpanam/Library/Developer/CoreSimulator/Devices/7E7C7562-E2D9-4559-9472-AB64724ECA69/data/Containers/Data/Application/C35A651F-7E6A-44BE-B2E3-682027521695/Documents/assets/"),
                    ),
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webViewController = controller;
                    controller.injectCSSFileFromUrl(urlFile:  Uri.parse("file:///Users/donaldmkpanam/Library/Developer/CoreSimulator/Devices/7E7C7562-E2D9-4559-9472-AB64724ECA69/data/Containers/Data/Application/C35A651F-7E6A-44BE-B2E3-682027521695/Documents/assets/style.css"));
                    
                  },
                  onLoadStart: (controller, url) {
                    setState(() {

                      urlController.text = htmlFile;

                    });
                  },
                  )
             
        
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
