import 'dart:io';

import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:nascp/models/oi_weight_model.dart';
import 'package:nascp/models/regimen_model.dart';
import 'package:nascp/screens/book_read.dart';
import 'package:nascp/screens/dosing_wheel/oi_search_result.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/dosing_wheel/regimens.dart';
import 'package:nascp/screens/dosing_wheel/search_result.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class OIProphy extends StatefulWidget {
  @override
  _OIProphyState createState() => _OIProphyState();
}

class _OIProphyState extends State<OIProphy> {
  DownloadAssetsController downloadAssetsController = DownloadAssetsController();
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  final formKey = new GlobalKey<FormState>();

  String email, password;
  bool closeTopContainer = false;
  Color greenColor = Color(0xFF0C8863);
  Color lightGreen = Color(0xFF10B875);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _chosenValue;
  var db, regimens, weights;
  int _regimenValue = 1;
  int _weightValue;
  var _formKey = GlobalKey<FormState>();
  String _dropdownError;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if ((_weightValue == null) || (_regimenValue == null)) {
      setState(() => _dropdownError = "Please select all options ");
      _isValid = false;
    }

    if (_isValid) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              OISearchResult(weight: _weightValue, regimen: _regimenValue)));
      //form is valid
    }
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  void loaders() async {
    await downloadAssetsController.init();
    final path = Path.join(downloadAssetsController.assetsDir,
        "dosing.db"); //returns a directory which stores permanent files
    var file = File(path);
    print(file.lengthSync());
    //var path1 = "/data/user/0/ng.gov.nascp/app_flutter/assets/update-summary.html";

    if (!File(path).existsSync()) {
      print(path);
      Navigator.pushNamed(context, '/updater');
      /* Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Updater(),
        ));*/

    } else {
      print("found path");
    }
    //print(path);
    db = await openDatabase(path);
    print("Started");

    this.regimens = await fetchARVRegimen();
    doQuery();

    setState(() {});
  }

  void doQuery() async {
    this.weights = await fetchOIWeight();
    setState(() {});
  }

  Future<List<RegimenModel>> fetchARVRegimen() async {
    //returns the memos as a list (array)
    //final db = await init();

    final maps = await db.query(
        "oi_regimen"); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return RegimenModel(id: maps[i]['id'], regimen: maps[i]['regimen']);
    });
  }

  Future<List<OIWeightModel>> fetchOIWeight() async {
    //returns the memos as a list (array)
    //final db = await init();
    if (_regimenValue == null) _regimenValue = 1;
    final maps = await db.rawQuery(
        """select id, oi_weight from oi_weights where oi_regimen = ?""",
        [
          _regimenValue,
        ]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return OIWeightModel(id: maps[i]['id'], weight: maps[i]['oi_weight']);
    });
  }

  @override
  void initState() {
    loaders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerScreen(),
        appBar: AppBar(
          title: Text("PEDS HIV Dosing Guide"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildLoginForm())));
  }

  _buildLoginForm() {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
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

          SizedBox(height: 35.0),
          //   Text('WHO 2020', style: TextStyle(fontFamily: 'Trueno', fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 125.0,
                  width: 200.0,
                  child: Stack(
                    children: [
                      Text('OI',
                          style: TextStyle(fontFamily: 'Trueno', fontSize: 30)),
                      Positioned(
                        top: 29.0,
                        child: Text('Prophylaxis',
                            style: TextStyle(
                                fontFamily: 'Trueno', fontSize: 35.0)),
                      ),

                      /* Positioned(
                          top: 27.0,
                          left: 195.0,
                          child: ImageIcon(AssetImage('assets/images/hiv.png'),
                                  size: 15.0))*/
                    ],
                  )),
              Image.asset('assets/images/art.png', width: 100)
            ],
          ),
          SizedBox(height: 15.0),
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(children: <Widget>[
                regimens == null
                    ? CircularProgressIndicator()
                    : Center(
                        child: Container(
                          padding: const EdgeInsets.all(0.0),
                          child: DropdownButton<int>(
                            value: _regimenValue,
                            isExpanded: true,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),
                            items: regimens.map<DropdownMenuItem<int>>(
                                (RegimenModel value) {
                              return DropdownMenuItem<int>(
                                value: value.id,
                                child: Text(value.regimen),
                              );
                            }).toList(),
                            hint: Text(
                              "SELECT REGIMEN",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Trueno'),
                            ),
                            onChanged: (int value2) {
                              weights = null;
                              _weightValue = null;
                              setState(() {
                                _regimenValue = value2;
                              });
                              doQuery();
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                weights == null
                    ? Text("Please select regimen")
                    : Center(
                        child: Container(
                          padding: const EdgeInsets.all(0.0),
                          child: DropdownButton<int>(
                            value: _weightValue,
                            isExpanded: true,
                            //elevation: 5,
                            style: TextStyle(color: Colors.black),
                            items: weights.map<DropdownMenuItem<int>>(
                                (OIWeightModel value) {
                              return DropdownMenuItem<int>(
                                value: value.id,
                                child: Text(value.weight),
                              );
                            }).toList(),
                            hint: Text(
                              "SELECT WEIGHT",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Trueno'),
                            ),
                            onChanged: (int value3) {
                              setState(() {
                                _weightValue = value3;
                                //fetchOIWeight();
                              });
                            },
                          ),
                        ),
                      ),
                SizedBox(height: 5.0),
                _dropdownError == null
                    ? SizedBox.shrink()
                    : Text(
                        _dropdownError ?? "",
                        style: TextStyle(color: Colors.red),
                      ),
                /*GestureDetector(
              onTap: () {
               // Navigator.of(context).push(
                   // MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: Container(
                  alignment: Alignment(1.0, 0.0),
                  padding: EdgeInsets.only(top: 15.0, left: 20.0),
                  child: InkWell(
                      child: Text('Forgot Password',
                          style: TextStyle(
                              color: greenColor,
                              fontFamily: 'Trueno',
                              fontSize: 11.0,
                              decoration: TextDecoration.underline))))),*/
                SizedBox(height: 50.0),
                GestureDetector(
                  onTap: () {
                    _validateForm();
                  },
                  child: Container(
                      height: 50.0,
                      child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: Colors.greenAccent,
                          color: greenColor,
                          elevation: 7.0,
                          child: Center(
                              child: Text('GET RECOMMENDED OI PROPHYLAXIS',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Trueno'))))),
                )
              ])),
          SizedBox(height: 20.0),
          Center(
              child: Text('Guidelines',
                  style: TextStyle(
                      fontFamily: 'Trueno', fontWeight: FontWeight.w800))),

          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: closeTopContainer ? 0 : 1,
            child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: size.width,
                alignment: Alignment.topCenter,
                height: closeTopContainer ? 0 : categoryHeight,
                child: categoriesScroller),
          ),
          /* Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('New to Spotify ?'),
            SizedBox(width: 5.0),
            InkWell(
                onTap: () {
                //  Navigator.of(context).push(
                 //     MaterialPageRoute(builder: (context) => SignupPage()));
                },
                child: Text('Register',
                    style: TextStyle(
                        color: greenColor,
                        fontFamily: 'Trueno',
                        decoration: TextDecoration.underline)))
          ])*/
        ]));
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();
  final String _url = 'https://www.who.int/publications/i/item/9789240031593';
  void _launchWHO() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 150;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: _launchWHO,
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Image.asset('assets/images/who.png',
                                  width: 50)),
                          Center(
                            child: Text(
                              "World Health Organization Guidelines",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: Colors.black,
                                  fontFamily: 'Trueno'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BookRead(2,
                        "National Guideline for HIV Prevention Treatment and Care");
                  }));
                },
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF),
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Image.asset('assets/images/coa.png',
                                width: 50)),
                        Center(
                          child: Text(
                            "National HIV Treatment Guidelines",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontFamily: 'Trueno',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
