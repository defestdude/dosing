import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nascp/utils/choose_time.dart';
import 'package:nascp/utils/constant.dart';

import 'package:nascp/utils/choose_model.dart';


class ARVDosageDisplay extends StatelessWidget {

  final String drug;
  final String dosage;
  final String route;
  final String duration;
  final String drug_instruction;

  const ARVDosageDisplay({
    Key key, this.drug, this.dosage, this.route, this.duration, this.drug_instruction
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$drug',
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