import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:nascp/models/regimen_model.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/dosing_wheel/search_result.dart';

import 'package:nascp/utils/my_header.dart';
import 'package:nascp/utils/user_info2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path; //used to join paths

class Regimens extends StatefulWidget {
  // In the constructor, require a Todo.
  const Regimens({Key key, this.weight, this.weightText}) : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;
  final String weightText;

  @override
  _RegimensState createState() => _RegimensState();
}

class _RegimensState extends State<Regimens> {
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
  List<Map> pfirstline;
  List<Map> afirstline;
  List<Map> special;
   List<Map> seondline;
  String weightBand;

  var firstlinedata;
  var alternatedata;
  var secondlinedata;
  var specialdata;

  var flineresults;

  void query() async {
    // raw query
    final path = Path.join(DownloadAssetsController.assetsDir, "dosing.db");
    //print(path);
    db = await openDatabase(path);
    setState(() {});
    pfirstline = await db.rawQuery(
        'select regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [1, widget.weight]);
    afirstline = await db.rawQuery(
        'select regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [2, widget.weight]);
    special = await db.rawQuery(
        'select regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [3, widget.weight]);

    // print the results
     //pfirstline.forEach((row) => print(row));
    //afirstline.forEach((row) => print(row));
    //special.forEach((row) => print(row));
    this.firstlinedata = await fetchFirstLine();
    this.alternatedata = await fetchAlternate();
    this.secondlinedata = await fetchSecondLine();
    this.specialdata = await fetchSpecial();
    this.weightBand = await fetchWeightBand();
    //print(widget.weight);
    setState(() {
          
        });
  }

  Future<List<RegimenModel>> fetchFirstLine() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select regimen.id, regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [1, widget.weight]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return RegimenModel(id: maps[i]['id'], regimen: maps[i]['regimen']);
    });
  }

   Future<List<RegimenModel>> fetchAlternate() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select regimen.id, regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [2, widget.weight]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return RegimenModel(id: maps[i]['id'], regimen: maps[i]['regimen']);
    });
  }

   Future<List<RegimenModel>> fetchSecondLine() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select regimen.id, regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [4, widget.weight]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return RegimenModel(id: maps[i]['id'], regimen: maps[i]['regimen']);
    });
  }

   Future<List<RegimenModel>> fetchSpecial() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select regimen.id, regimen.regimen as regimen, wt_rg_wt_gp.weight, wt_rg_wt_gp.regimen_weight_group from regimen join wt_rg_wt_gp on regimen.regimen_weight_group = wt_rg_wt_gp.regimen_weight_group where regimen.line_type = ? and wt_rg_wt_gp.weight = ?',
        [3, widget.weight]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return RegimenModel(id: maps[i]['id'], regimen: maps[i]['regimen']);
    });
  }

  Future<String> fetchWeightBand() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select weight.weight_band from weight where id = ?',
        [widget.weight]); //query all the rows in a table as an array of maps

    return maps[0]['weight_band'];
  }

  Future<List<dynamic>> pline() async {
    final path = Path.join(DownloadAssetsController.assetsDir, "dosing.db");
    db = await openDatabase(path);

    setState(() {});
    var pfline = await db.rawQuery(
        'select regimen.regimen as regimen from regimen join regimen_weight on regimen.id = regimen_weight.regimen where regimen.line_type = ? and regimen_weight.weight=?',
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
                  this.weightBand == null ? Text("") : UserInfo2(weightBand:this.weightBand),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Preferred First Line Regimen",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                firstlinedata == null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text("None"),
                      )
                      :Column(
                  children:  firstlinedata.map<Widget>((RegimenModel regimen) {
                          return new DrugCard(
                            text: regimen.regimen,
                            weight: widget.weight,
                            weightBand: this.weightBand,
                            regimen: regimen.id,
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Alternative First Line Regimens",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                alternatedata == null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text("None"),
                      )
                      :Column(
                  children:  alternatedata.map<Widget>((RegimenModel regimen) {
                          return new DrugCard(
                            text: regimen.regimen,
                            icon: "assets/icons/Bell.svg",
                            weight: widget.weight,
                            weightBand: this.weightBand,
                            regimen: regimen.id,
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchResult(),
                              ));
                            },
                          );
                        }).toList(),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Special Circumstances",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                specialdata == null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text("None"),
                      )
                      :Column(
                  children:  specialdata.map<Widget>((RegimenModel regimen) {
                          return new DrugCard(
                            text: regimen.regimen,
                            icon: "assets/icons/Bell.svg",
                            weight: widget.weight,
                            weightBand: this.weightBand,
                            regimen: regimen.id,
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchResult(),
                              ));
                            },
                          );
                        }).toList(),
                ),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text("Second Line",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                ),
                secondlinedata == null
                      ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Text("None"),
                      )
                      :Column(
                  children:  secondlinedata.map<Widget>((RegimenModel regimen) {
                          return new DrugCard(
                            text: regimen.regimen,
                            icon: "assets/icons/Bell.svg",
                            weight: widget.weight,
                            weightBand: this.weightBand,
                            regimen: regimen.id,
                            press: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchResult(),
                              ));
                            },
                          );
                        }).toList(),
                ),
              ],
            ),
         /*   AnimatedOpacity(
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
    this.press,this.weight, this.regimen
  }) : super(key: key);

  final String text, icon, weightBand;
  final press;
  final int weight, regimen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SearchResult(weight: this.weight, regimenid: this.regimen, regimenText: this.text, weightText: this.weightBand,),
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
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 10),
                //height: categoryHeight,
                decoration: BoxDecoration(
                    color: Color(0xFF0C8863),
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: ImageIcon(AssetImage('assets/images/baby.png'),
                            size: 35.0, color: Color(0xFFFFFFFF)),
                      ),
                      Text(
                        "Postnatal Infant ARV Prophylaxis",
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontFamily: 'Trueno',
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                            "Preferred 1L Peds ART & Weight-Based Dosing",
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
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 20),
                //height: categoryHeight,
                decoration: BoxDecoration(
                    color: Color(0xFF0C8863),
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: ImageIcon(AssetImage('assets/images/prophy.png'),
                            size: 35.0, color: Color(0xFFFFFFFF)),
                      ),
                      Center(
                        child: Text(
                          "Preferred Sequencing Pediatric ART",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Trueno',
                          ),
                        ),
                      ),
                    ],
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
