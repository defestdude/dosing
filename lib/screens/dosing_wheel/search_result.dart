import 'package:download_assets/download_assets.dart';
import 'package:flutter/material.dart';
import 'package:nascp/models/peds_dosage_model.dart';
import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/utils/choose_date.dart';
import 'package:nascp/utils/choose_model.dart';
import 'package:nascp/utils/choose_time_group.dart';
import 'package:nascp/utils/dosage_display.dart';
import 'package:nascp/utils/my_appbar.dart';
import 'package:nascp/utils/my_header.dart';
import 'package:nascp/utils/user_info.dart';
import 'package:nascp/utils/constant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path; //used to join paths

class SearchResult extends StatefulWidget {
  // In the constructor, require a Todo.
  const SearchResult({Key key, this.weight, this.weightText, this.regimenid, this.regimenText})
      : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;
  final int regimenid;
  final String weightText;
  final String regimenText;


  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  DownloadAssetsController downloadAssetsController = DownloadAssetsController();
  var db;
  String regimenInstructions;
  List<PedsDosageModel> dosageResults;

  @override
  void initState() {
    query();
    super.initState();
  }

  void query() async {
    // raw query
    await downloadAssetsController.init();
    final path = Path.join(downloadAssetsController.assetsDir, "dosing.db");
    db = await openDatabase(path);
    this.dosageResults = await fetchDosageResults();
    //this.regimenInstructions = "";
    this.regimenInstructions = await fetchInstructions();
    print(widget.weightText);
    setState(() {});
  }

  Future<List<PedsDosageModel>> fetchDosageResults() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        "select distinct drugs.drug, dosage.dose, weight.weight_band, ifnull(drug_instructions.drug_instruction,'') as drug_instruction,dosage.strength, drug_instructions.has_image from dosage join weight on dosage.weight = weight.id join drugs on dosage.drugs = drugs.id join drugs_regimen on drugs.id = drugs_regimen.drugs join regimen on drugs_regimen.regimen = regimen.id join wt_rg_wt_gp on wt_rg_wt_gp.regimen_weight_group = regimen.regimen_weight_group left join drug_instructions on dosage.drug_instruction = drug_instructions.id where regimen.id = ? and dosage.weight = ?",
        [
          widget.regimenid,
          widget.weight
        ]); //query all the rows in a table as an array of maps

    return List.generate(maps.length, (i) {
      //create a list of memos
      return PedsDosageModel(
          drug: maps[i]['drug'],
          dose: maps[i]['dose'],
          strength: maps[i]['strength'],
          instructions: maps[i]['drug_instruction'],
          weightBand: maps[i]['weightBand'],
          has_image: maps[i]['has_image']);
    });
  }

  Future<String> fetchInstructions() async {
    //returns the memos as a list (array)

    //final db = await init();
    final maps = await db.rawQuery(
        "select instructions from regimen_instructions left join regimen on regimen.regimen_instruction = regimen_instructions.id where regimen.id = ?",
        [widget.regimenid]); //query all the rows in a table as an array of maps

    return maps[0]['instructions'];
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
                  UserInfo(regimenText: widget.regimenText, weightText: widget.weightText,),
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
                         dosageResults.isEmpty ? [Text("No Dosage for the selected parameters")] : dosageResults.map<Widget>((PedsDosageModel dosage) {
                      return new DosageDisplay(
                        drug: dosage.drug,
                        dosage: dosage.dose,
                        strength: dosage.strength,
                        instructions: dosage.instructions,
                        has_image: dosage.has_image
                      );
                    }).toList(),
                  ),

                      SizedBox(
                        height: 32,
                      ),
                      (regimenInstructions == null || regimenInstructions == ' ') ? Text(" ") : ChooseTimeGroup(
                        title: 'Instructions for Use',
                        story:regimenInstructions,
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
