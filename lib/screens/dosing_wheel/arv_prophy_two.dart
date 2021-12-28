import 'dart:io';

import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:nascp/models/arv_age_model.dart';
import 'package:nascp/models/arv_risk_model.dart';
import 'package:nascp/models/arv_weight_model.dart';
import 'package:nascp/screens/book_read.dart';
import 'package:nascp/screens/dosing_wheel/arv_regimens.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/dosing_wheel/regimens.dart';
import 'package:nascp/screens/dosing_wheel/search_result.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart'; //used to join paths

class ARVProphyAdditional extends StatefulWidget {
  const ARVProphyAdditional({Key key, this.weight,  this.age})
      : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;

  final int age;

  @override
  _ARVProphyAdditionalState createState() => _ARVProphyAdditionalState();
}

class _ARVProphyAdditionalState extends State<ARVProphyAdditional> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  final formKey = new GlobalKey<FormState>();

  String email, password;
  bool closeTopContainer = false;
  Color greenColor = Color(0xFF0C8863);
  Color lightGreen = Color(0xFF10B875);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _chosenValue;
  var db;
  var weights, age, risk;
  int _q1Value, _q2Value, _q3Value, _q4Value;
  int risktype = 1;
  var _formKey = GlobalKey<FormState>();
  String _dropdownError;

  //To check fields during submit

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if ((_q1Value == null) ||
        (_q2Value == null) ||
        (_q3Value == null) ||
        (_q4Value == null)) {
      setState(() => _dropdownError = "Please answer all questions ");
      _isValid = false;
    }

    if (_isValid) {
       if ((_q1Value == 1) ||
        (_q2Value == 1) ||
        (_q3Value == 1) ||
        (_q4Value == 1)) {
          risktype = 2;
    } else if ((_q1Value == 2) &&
        (_q2Value == 2) &&
        (_q3Value == 2) &&
        (_q4Value == 2)) {
          risktype = 1;
        }
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ARVRegimens(
          weight: widget.weight,
          risk_type: risktype,
          age: widget.age,
        ),
      ));
      //form is valid
    }
  }

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
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




  @override
  void initState() {

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
                      Text('Post-natal ',
                          style: TextStyle(fontFamily: 'Trueno', fontSize: 30)),
                      Positioned(
                        top: 39.0,
                        child: Text('ARV Prophylaxis',
                            style: TextStyle(
                                fontFamily: 'Trueno', fontSize: 25.0)),
                      ),

                      /* Positioned(
                          top: 27.0,
                          left: 195.0,
                          child: ImageIcon(AssetImage('assets/images/hiv.png'),
                                  size: 15.0))*/
                    ],
                  )),
              Image.asset('assets/images/prophy1.png', width: 100)
            ],
          ),
          SizedBox(height: 15.0),
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(children: <Widget>[
                Text(
                    "Is the infant born to a known HIV positive woman who received <4 weeks of ART at the time of delivery?"),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButton<int>(
                      value: _q1Value,
                      isExpanded: true,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      items: <String, int>{
                        'YES': 1,
                        'NO': 2,
                      }
                          .map((description, newvalue) {
                            return MapEntry(
                                description,
                                DropdownMenuItem<int>(
                                  value: newvalue,
                                  child: Text(description),
                                ));
                          })
                          .values
                          .toList(),
                      hint: Text(
                        "SELECT YES OR NO",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Trueno'),
                      ),
                      onChanged: (int value) {
                        setState(() {
                          _q1Value = value;
                        });
                      },
                    ),
                  ),
                ),
                Text(
                    "Is the infant born to a known HIV positive woman with viral load >1000 copies/mL in the 4 weeks before delivery?"),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButton<int>(
                      value: _q2Value,
                      isExpanded: true,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      items: <String, int>{
                        'YES': 1,
                        'NO': 2,
                      }
                          .map((description, newvalue) {
                            return MapEntry(
                                description,
                                DropdownMenuItem<int>(
                                  value: newvalue,
                                  child: Text(description),
                                ));
                          })
                          .values
                          .toList(),
                      hint: Text(
                        "SELECT YES OR NO",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Trueno'),
                      ),
                      onChanged: (int value) {
                        setState(() {
                          _q2Value = value;
                        });
                      },
                    ),
                  ),
                ),
                  Text(
                    "Is the infant born to a woman with incident HIV infection during pregnancy (this includes women diagnosed in labour) or breastfeeding?"),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButton<int>(
                      value: _q3Value,
                      isExpanded: true,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      items: <String, int>{
                        'YES': 1,
                        'NO': 2,
                      }
                          .map((description, newvalue) {
                            return MapEntry(
                                description,
                                DropdownMenuItem<int>(
                                  value: newvalue,
                                  child: Text(description),
                                ));
                          })
                          .values
                          .toList(),
                      hint: Text(
                        "SELECT YES OR NO",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Trueno'),
                      ),
                      onChanged: (int value) {
                        setState(() {
                          _q3Value = value;
                        });
                      },
                    ),
                  ),
                ),
                 Text(
                    " Is the infant born to a woman identified for the first time during the postpartum period, with or without a negative HIV test prenatally?"),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(0.0),
                    child: DropdownButton<int>(
                      value: _q4Value,
                      isExpanded: true,
                      //elevation: 5,
                      style: TextStyle(color: Colors.black),
                      items: <String, int>{
                        'YES': 1,
                        'NO': 2,
                      }
                          .map((description, newvalue) {
                            return MapEntry(
                                description,
                                DropdownMenuItem<int>(
                                  value: newvalue,
                                  child: Text(description),
                                ));
                          })
                          .values
                          .toList(),
                      hint: Text(
                        "SELECT YES OR NO",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Trueno'),
                      ),
                      onChanged: (int value) {
                        setState(() {
                          _q4Value = value;
                        });
                      },
                    ),
                  ),
                ),
                _dropdownError == null
                    ? SizedBox.shrink()
                    : Text(
                        _dropdownError ?? "",
                        style: TextStyle(color: Colors.red),
                      ),
                SizedBox(height: 50.0),
                GestureDetector(
                  onTap: () {
                    _validateForm();
                    //if (checkFields()) AuthService().signIn(email, password, context);
                  },
                  child: Container(
                      height: 50.0,
                      child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          shadowColor: Colors.greenAccent,
                          color: greenColor,
                          elevation: 7.0,
                          child: Center(
                              child: Text('GET RECOMMENDED ARV PROPHYLAXIS',
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
