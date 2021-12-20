import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:nascp/utils/choose_time.dart';
import 'package:nascp/utils/constant.dart';

import 'package:nascp/utils/choose_model.dart';


class DosageDisplay extends StatelessWidget {

  final String drug;
  final String dosage;
  final String strength;
  final String weightBand;
  final String instructions;
  final int has_image;

  const DosageDisplay({
    Key key, this.drug, this.dosage, this.strength, this.weightBand, this.instructions, this.has_image
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
        Text('$strength'),
        SizedBox(
          height: 5,
        ),
        Text("Dosage: "+this.dosage),
        SizedBox(
          height: 5,
        ),
        (this.instructions.trim().isEmpty) ? 
       Row(children: [Text(" ")],): 
        ExpandablePanel(
      header: Text("Instructions", style: TextStyle(fontWeight: FontWeight.w800),),
      collapsed: Text(this.instructions, softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.justify,),
      expanded: Text(this.instructions, softWrap: true, textAlign: TextAlign.justify,),),
        SizedBox(
          height:15,
        ),
        has_image == 1 ? Text("") : InteractiveViewer(
  maxScale: 10,
  child: Image.asset("assets/documents/ral.png"),),
        
      ],
    );
  }


}