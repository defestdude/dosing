import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:nascp/models/regimen_model.dart';
import 'package:nascp/screens/dosing_wheel/arv_search_result.dart';
import 'package:nascp/screens/dosing_wheel/dosing_wheel_home.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/dosing_wheel/search_result.dart';
import 'package:nascp/utils/arv_info.dart';

import 'package:nascp/utils/my_header.dart';
import 'package:nascp/utils/user_info2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path; //used to join paths

class ARVRegimens extends StatefulWidget {
  // In the constructor, require a Todo.
  const ARVRegimens({Key key, this.weight, this.risk_type, this.age}) : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;
  final int risk_type;
  final int age;

  @override
  _ARVRegimensState createState() => _ARVRegimensState();
}

class _ARVRegimensState extends State<ARVRegimens> {
  // Declare a field that holds the Todo.

  @override
  void initState() {
    loaders();
    query();
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool closeTopContainer = false;
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  var db;
  List<Map> pRegimen;
  String weightBand, ageText;
  var regimendata;
  var flineresults;

  void query() async {
    // raw query
    final path = Path.join(DownloadAssetsController.assetsDir, "dosing.db");
    //print(path);
    db = await openDatabase(path);
    setState(() {});
    pRegimen = await db.rawQuery(
        'select regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [1, widget.weight]);
    this.regimendata = await fetchRegimen();
    this.weightBand = await fetchWeightBand();
    this.ageText = await fetchAgeText();
    //print(widget.weight);
    setState(() {      
    });
  }

  Future<List<RegimenModel>> fetchRegimen() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select id, regimen from arv_regimen where risk_type =  ?',
        [widget.risk_type]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return RegimenModel(id: maps[i]['id'], regimen: maps[i]['regimen']);
    });
  }




  Future<String> fetchWeightBand() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select arv_weight from arv_weights where id = ?',
        [widget.weight]); //query all the rows in a table as an array of maps

    return maps[0]['arv_weight'];
  }

   Future<String> fetchAgeText() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select arv_age from arv_age where id = ?',
        [widget.weight]); //query all the rows in a table as an array of maps

    return maps[0]['arv_age'];
  }


  Future<List<dynamic>> pline() async {
    final path = Path.join(DownloadAssetsController.assetsDir, "dosing.db");
    db = await openDatabase(path);

    setState(() {});
    var pfline = await db.rawQuery(
        'select regimen.id, regimen.regimen as regimen from regimen join regimen_weight on regimen.id = regimen_weight.regimen where regimen.line_type = ? and regimen_weight.weight=?',
        [1, widget.weight]);
    return List.generate(pfline.length, (i) {
      //create a list of memos
      return RegimenModel(id: pfline[i]['id'], regimen: pfline[i]['regimen']);
    });
    //  return pfline.toList();
  }

  void loaders() async {
    this.flineresults = await pline();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            MyHeader(
              height: 258,
              imageUrl: 'assets/images/hiv.png',
              child: Column(
                children: <Widget>[
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            icon: Icon(Icons.menu),
                            onPressed: () {
                              _scaffoldKey.currentState.openDrawer();
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  this.weightBand == null ? Text("") : ARVInfo(weightBand:this.weightBand, ageText: this.ageText,),
             
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Post-natal ARV Prophylaxis",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                regimendata == null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text("None"),
                      )
                      :Column(
                  children:  regimendata.map<Widget>((RegimenModel regimen) {
                          return new DrugCard(
                            text: regimen.regimen,
                            weight: widget.weight,
                            weightBand: this.weightBand,
                            regimen: regimen.id,
                            risk_type: widget.risk_type,
                            age: widget.age,
                            ageText: this.ageText,
                            icon: "assets/icons/Bell.svg",
                            press: () {
                             // print(widget.weight);
                            // Navigator.of(context).push(MaterialPageRoute(
                              //  builder: (context) => SearchResult(weight: widget.weight, regimenid: regimen.id),
                              //));
                            },
                          );
                        }).toList(),
                ),
                SizedBox(
                  height: 32,
                ),

                
              ],
            ),
          /*  AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: closeTopContainer ? 0 : 1,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer ? 0 : categoryHeight,
                  child: categoriesScroller),
            ),*/
          ],
        ),
      ),
    );
  }
}

class DrugCard extends StatelessWidget {
  const DrugCard({
    Key key,
    @required this.text,
    @required this.icon,
    this.weightBand,
    this.press,this.weight, this.regimen, this.risk_type, this.age, this.ageText
  }) : super(key: key);

  final String text, icon, weightBand, ageText;
  final press;
  final int weight, regimen, risk_type, age;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ARVSearchResult(weight: this.weight, regimenid: this.regimen, regimenText: this.text, risk_type: this.risk_type,age: this.age, weightText: this.weightBand,ageText: this.ageText,),
          ));
          //if (checkFields()) AuthService().signIn(email, password, context);
        },
        child: Container(
            height: 50.0,
            child: Material(
              borderRadius: BorderRadius.circular(15.0),
              shadowColor: Colors.black,
              color: Colors.white,
              elevation: 7.0,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Expanded(child: Text(text)),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            )),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DWLHome(),
        ));
                },
                child: Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 10),
                  //height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                              child: Image.asset('assets/images/peds.png',
                                  width: 40)),
                          Center(
                            child: Text(
                              "Dosing Wheel Home",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
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
             
            ],
          ),
        ),
      ),
    );
  }
}
