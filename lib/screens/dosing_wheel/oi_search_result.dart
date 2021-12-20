import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:nascp/models/arv_dosage_model.dart';
import 'package:nascp/models/oi_dosage_model.dart';
import 'package:nascp/models/peds_dosage_model.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/utils/arv_dosage_display.dart';
import 'package:nascp/utils/choose_date.dart';
import 'package:nascp/utils/choose_model.dart';
import 'package:nascp/utils/choose_time_group.dart';
import 'package:nascp/utils/dosage_display.dart';
import 'package:nascp/utils/my_appbar.dart';
import 'package:nascp/utils/my_header.dart';
import 'package:nascp/utils/oi_dosage_display.dart';
import 'package:nascp/utils/user_info.dart';
import 'package:nascp/utils/constant.dart';
import 'package:nascp/utils/user_info_3.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path; //used to join paths

class OISearchResult extends StatefulWidget {
  // In the constructor, require a Todo.
  const OISearchResult({Key key, this.weight, this.regimen})
      : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;
  final int regimen;
 


  @override
  _OISearchResultState createState() => _OISearchResultState();
}

class _OISearchResultState extends State<OISearchResult> {
  var db;
  String regimenInstructions;
  List<OIDosageModel> dosageResults;
  var _weiText, _regText;

  @override
  void initState() {
    query();
    super.initState();
  }

   Future<String> fetchWeightText() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select oi_weight from oi_weights where id = ?',
        [widget.weight]); //query all the rows in a table as an array of maps
    
    return maps[0]['oi_weight'];
  }

   Future<String> fetchRegimenText() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        'select regimen from oi_regimen where id = ?',
        [widget.regimen]); //query all the rows in a table as an array of maps
//print(maps[0].toString());
    return maps[0]['regimen'];
  }

  void query() async {
    // raw query
    final path = Path.join(DownloadAssetsController.assetsDir, "dosing.db");
    db = await openDatabase(path);
    this.dosageResults = await fetchDosageResults();
    //this.regimenInstructions = "";
    _weiText = await fetchWeightText();
    _regText = await fetchRegimenText();
    print(_regText);
    setState(() {});
  }

  Future<List<OIDosageModel>> fetchDosageResults() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        """select frequency, drugs.drug, oi_regimen.regimen, drug_instructions.drug_instruction, no_of_tablets, dosage, oi_weights.oi_weight, strength, duration from oi_dosage
join drug_instructions on oi_dosage.drug_instruction = drug_instructions.id
join drugs on oi_dosage.drug = drugs.id
join oi_weights on oi_dosage.oi_weight = oi_weights.id
join oi_regimen on oi_dosage.oi_regimen = oi_regimen.id
where oi_dosage.oi_weight = ? and oi_dosage.oi_regimen = ?""",
        [
          widget.weight,
          widget.regimen
        ]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return OIDosageModel(
          drug: maps[i]['drug'],
          dose: maps[i]['dosage'],
          frequency: maps[i]['frequency'],
          duration: maps[i]['duration'],
          strength: maps[i]['strength'],
          no_of_tablets: maps[i]['no_of_tablets']
          ,
          drug_instruction: maps[i]['drug_instruction']);
    });
  }


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                 UserInfo3(regimenText: _regText.toString(), weightText: _weiText.toString(),ageText: "--",),
                ],
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(left:20.0),
             child: Text('Dosage: ',
                            style: TextStyle(fontFamily: 'Trueno', fontSize: 20, fontWeight: FontWeight.w700)),
           ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   dosageResults == null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2, vertical: 10),
                    child: Text("None"),
                  )
                : Column(
                    children:   dosageResults.isEmpty ? [Text("No Dosage for the selected parameters")] :
                        dosageResults.map<Widget>((OIDosageModel dosage) {
                      return new OIDosageDisplay(
                        drug: dosage.drug,
                        dosage: dosage.dose,
                        frequency: dosage.frequency,
                        strength: dosage.strength,
                        drug_instruction: dosage.drug_instruction,
                        no_of_tablets: dosage.no_of_tablets,
                      );
                    }).toList(),
                  ),

                      SizedBox(
                        height: 32,
                      ),
    
                ],
              ),
            )
            
          ],
        ),
      ),
    );
  }
}

class ChooseSlot extends StatelessWidget {
  const ChooseSlot({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Dosage',
          style: TextStyle(
            color: mTitleTextColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ChooseDate(
              week: '3 - 5.9 kg',
              date: '1',
            ),
            ChooseDate(
              week: '6 - 9.9kg',
              date: '1.5',
              check: true,
            ),
            ChooseDate(
              week: '10 - 13.9kg',
              date: '2',
            ),
            ChooseDate(
              week: '14 - 19.9kg',
              date: '2.5',
            ),
          ],
        )
      ],
    );
  }
}
