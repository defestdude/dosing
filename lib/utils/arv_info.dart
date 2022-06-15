import 'package:flutter/material.dart';
import 'package:nascp/utils/constant.dart';

class ARVInfo extends StatelessWidget {
  const ARVInfo({
    Key key,
    this.weightBand,
    this.ageText
  }) : super(key: key);

  final String weightBand, ageText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/hiv.png',
            width: 100,
            height: 100,
          ),
 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 242,
                child: Text(
                  'Post-natal ARV Prophylaxis',
                  style: TextStyle(
                    color: mTitleTextColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Truedo"
                  ),
                  maxLines: 3,
                ),
              ),
              Text(weightBand,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              SizedBox(
  width: 160,
  child: Text(ageText,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
              )
            ],
          )
        ],
      ),
    );
  }
}
