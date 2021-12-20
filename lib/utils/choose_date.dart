import 'package:flutter/material.dart';
import 'package:nascp/utils/constant.dart';

class ChooseDate extends StatelessWidget {
  final String week;
  final String date;
  final bool check;

  const ChooseDate({
    Key key,
    this.week,
    this.date,
    this.check = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          week,
          style: TextStyle(
            color: mTitleTextColor,
            fontSize: 12,
            fontFamily: "Truedo",
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Container(
          width: 58,
          height: 58,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: check ? mYellowColor : Colors.transparent,
            border: Border.all(
                color: check ? mYellowColor : mTitleTextColor, width: 0.5,),
            borderRadius: BorderRadius.circular(36),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(
                  color: check ? Colors.white : mTitleTextColor,
                  fontSize: 14,
                  fontFamily: "Truedo",
                  fontWeight: FontWeight.w800
                ),
              ),
              Text(
                "Once Daily",
                style: TextStyle(
                  color: check ? Colors.white : mTitleTextColor,
                  fontSize: 9,
                  fontFamily: "Truedo",
                  fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
