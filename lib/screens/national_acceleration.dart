import 'package:flutter/material.dart';
import 'package:nascp/utils/GridBuilder.dart';
import 'package:nascp/utils/GridItems.dart';
import 'package:nascp/widgets/grid_object.dart';


class NationalAcceleration extends StatelessWidget {
  GridItem item1 = new GridItem(
      title: "ABOUT THE NAP",
      icon: 'assets/images/icons/info.png',
      touchPoint: "about"
  );
 
  GridItem item2 = new GridItem(
      title: "COUNTRY ANALYSIS",
      icon: 'assets/images/icons/country.png',
      touchPoint: "country"
  );
   GridItem item3 = new GridItem(
      title: "TARGETS",
      icon: 'assets/images/icons/targets.png',
      touchPoint: "targets"
  );
      GridItem item4 = new GridItem(
      title: "BUDGET",
      icon: 'assets/images/icons/budget.png',
      touchPoint: "budget"
  );
   GridItem item5 = new GridItem(
      title: "SERVICE DELIVERY",
      subtitle: "FRAMEWORK",
     icon: 'assets/images/icons/service.png',
     touchPoint: "service"
  );
  GridItem item6 = new GridItem(
      title: "STRATEGIC",
      subtitle: "INTERVENTIONS",
      icon: 'assets/images/icons/interventions.png',
      touchPoint: "interventions"
  );

  @override Widget build(BuildContext context) {
    List<GridItem> myList = [item1, item2, item3, item4, item5, item6];
    String pageTitle = "National Acceleration Plan";
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
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
                SizedBox(),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child:
                Text("National Acceleration Plan",textAlign: TextAlign.center,),
                ),
              
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
