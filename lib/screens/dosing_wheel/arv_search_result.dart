import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:nascp/models/arv_dosage_model.dart';
import 'package:nascp/models/peds_dosage_model.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/utils/arv_dosage_display.dart';
import 'package:nascp/utils/choose_date.dart';
import 'package:nascp/utils/choose_model.dart';
import 'package:nascp/utils/choose_time_group.dart';
import 'package:nascp/utils/dosage_display.dart';
import 'package:nascp/utils/my_appbar.dart';
import 'package:nascp/utils/my_header.dart';
import 'package:nascp/utils/user_info.dart';
import 'package:nascp/utils/constant.dart';
import 'package:nascp/utils/user_info_3.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path; //used to join paths

class ARVSearchResult extends StatefulWidget {
  // In the constructor, require a Todo.
  const ARVSearchResult({Key key, this.weight, this.risk_type, this.regimenid, this.age, this.regimenText, this.weightText, this.ageText})
      : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;
  final int regimenid, risk_type, age;
  final String regimenText, weightText, ageText;


  @override
  _ARVSearchResultState createState() => _ARVSearchResultState();
}

class _ARVSearchResultState extends State<ARVSearchResult> {
  var db;
  String regimenInstructions;
  List<ARVDosageModel> dosageResults;

  @override
  void initState() {
    query();
    super.initState();
  }

  void query() async {
    // raw query
    final path = Path.join(DownloadAssetsController.assetsDir, "dosing.db");
    db = await openDatabase(path);
    this.dosageResults = await fetchDosageResults();
    //this.regimenInstructions = "";
    setState(() {});
  }

  Future<List<ARVDosageModel>> fetchDosageResults() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        """select drugs.drug, dose, route, duration, drug_instructions.drug_instruction from arv_dosage 
join arv_drugs_regimen on arv_dosage.drug_regimen = arv_drugs_regimen.id
join drugs on arv_drugs_regimen.drug = drugs.id 
join arv_regimen on arv_drugs_regimen.regimen = arv_regimen.id
join drug_instructions on arv_dosage.drug_instruction = drug_instructions.id
where arv_regimen.id = ? and arv_dosage.weight = ? and arv_regimen.risk_type = ? and arv_dosage.age = ?""",
        [
          widget.regimenid,
          widget.weight,
          widget.risk_type,
          widget.age
        ]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return ARVDosageModel(
          drug: maps[i]['drug'],
          dose: maps[i]['dose'],
          route: maps[i]['route'],
          duration: maps[i]['duration'],
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
                  UserInfo3(regimenText: widget.regimenText, weightText: widget.weightText,ageText: widget.ageText,),
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
                    children:
                    dosageResults.isEmpty ? [Text("No Dosage for the selected parameters")] :
                        dosageResults.map<Widget>((ARVDosageModel dosage) {
                      return new ARVDosageDisplay(
                        drug: dosage.drug,
                        dosage: dosage.dose,
                        route: dosage.route,
                        drug_instruction: dosage.drug_instruction,
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
