import 'package:flutter/material.dart';
import 'package:nascp/utils/constant.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    Key key,
    this.regimenText,
    this.weightText
  }) : super(key: key);

  final String regimenText, weightText;

  @override
  Widget build(BuildContext context) {
    print(this.regimenText);
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
              Text(this.weightText,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),)
            ],
          )
        ],
      ),
    );
  }
}
