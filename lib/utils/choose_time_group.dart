import 'package:flutter/material.dart';
import 'package:nascp/utils/choose_time.dart';
import 'package:nascp/utils/constant.dart';

import 'package:nascp/utils/choose_model.dart';


class ChooseTimeGroup extends StatelessWidget {

  final String title;
  final String story;

  const ChooseTimeGroup({
    Key key, this.title, this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: mTitleTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: "Truedo"
          ),
        ),
        SizedBox(
          height: 18,
        ),
        Text(story)
      ],
    );
  }


}