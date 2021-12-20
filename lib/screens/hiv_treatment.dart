import 'package:flutter/material.dart';
import 'package:nascp/utils/GridBuilder.dart';
import 'package:nascp/utils/GridItems.dart';
import 'package:nascp/widgets/grid_object.dart';


class HIVTreatment extends StatelessWidget {
  GridItem item1 = new GridItem(
      title: "UPDATE SUMMARY",
      icon: 'assets/images/icons/update_summary.png',
      touchPoint: "update-summary"
  );
 
  GridItem item2 = new GridItem(
      title: "HIV Diagnosis",
      icon: 'assets/images/icons/hiv_diagnosis.png',
      touchPoint: "hiv_diagnosis"
  );
   GridItem item3 = new GridItem(
      title: "FIRST-LINE",
      icon: 'assets/images/icons/first_line.png',
      touchPoint: "first-line"
  );
      GridItem item4 = new GridItem(
      title: "SECOND-LINE",
      icon: 'assets/images/icons/second_line.png',
      touchPoint: "second-line"
  );
   GridItem item5 = new GridItem(
      title: "PMTCT",
     icon: 'assets/images/icons/pmtct.png',
     touchPoint: "pmtct"
  );
  GridItem item6 = new GridItem(
      title: "HIV PROPHYLAXIS",
      icon: 'assets/images/icons/hiv_prophylaxis.png',
      touchPoint: "hiv-prophylaxis"
  );
  GridItem item7 = new GridItem(
      title: "ADVERSE DRUG",
     icon: 'assets/images/icons/adverse_reactions.png',
     touchPoint: "adr",
    subtitle: "REACTIONS"
  );
  GridItem item8 = new GridItem(
      title: "ADVANCED HIV",
      icon: 'assets/images/icons/ahd.png',
      subtitle: 'Diseases',
      touchPoint: "ahd"
  );

  @override Widget build(BuildContext context) {
    List<GridItem> myList = [item1, item2, item3, item4, item5, item6, item7, item8];
    String pageTitle = "National Guideline for HIV Prevention Treatment and Care";
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {Navigator.pop(context);}
                ),
                SizedBox
                ( width: MediaQuery.of(context).size.width * 0.65,
                  child: Text("National Guideline for HIV Prevention Treatment and Care", overflow: TextOverflow.ellipsis, textAlign: TextAlign.center, maxLines: 2,)),
 
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridBuilder(myList, pageTitle)
         //GridObject()
        ],
      ),
    );
  }
}
