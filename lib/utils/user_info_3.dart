import 'package:flutter/material.dart';
import 'package:nascp/utils/constant.dart';

class UserInfo3 extends StatelessWidget {
  const UserInfo3({
    Key key,
    this.regimenText,
    this.weightText,
    this.ageText
  }) : super(key: key);

  final String regimenText, weightText, ageText;

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
                width: 250,
                child: Text(
                  regimenText,
                  style: TextStyle(
                    color: mTitleTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Truedo"
                  ),
                  maxLines: 3,
                ),
              ),
              Text(this.weightText,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
              Text(this.ageText,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
            ],
          )
        ],
      ),
    );
  }
}
