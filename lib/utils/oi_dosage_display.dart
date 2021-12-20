import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nascp/utils/choose_time.dart';
import 'package:nascp/utils/constant.dart';

import 'package:nascp/utils/choose_model.dart';


class OIDosageDisplay extends StatelessWidget {

  final String drug;
  final String dosage;
  final String frequency;
  final String duration;
  final String strength;
  final String drug_instruction;
  final String no_of_tablets;

  const OIDosageDisplay({
    Key key, this.drug, this.dosage, this.frequency, this.duration, this.drug_instruction, this.strength, this.no_of_tablets
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$drug ($strength)',
          style: TextStyle(
            color: mTitleTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Truedo"
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text('$drug'),
        SizedBox(
          height: 5,
        ),
        Text("Dosage: "+this.dosage),
        SizedBox(
          height: 5,
        ),
        Text("Number of Tablets: "+this.no_of_tablets),
        SizedBox(
          height: 5,
        ),
         Text("Frequency: "+this.frequency),
        SizedBox(
          height: 5,
        ),
        (this.drug_instruction.trim().isEmpty) ? 
       Row(children: [Text(" ")],): ExpandablePanel(
      header: Text("Instructions", style: TextStyle(fontWeight: FontWeight.w800),),
      collapsed: Text(this.drug_instruction, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.justify,),
      expanded: Text(this.drug_instruction, softWrap: true, textAlign: TextAlign.justify,),

    ),
        SizedBox(
          height:15,
        ),
        
      ],
    );
  }


}