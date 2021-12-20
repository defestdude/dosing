import 'package:flutter/material.dart';
import 'package:nascp/screens/html_renderer.dart';
import 'package:nascp/utils/GridItems.dart';


class GridObject extends StatelessWidget {
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


 

  @override
  Widget build(BuildContext context) {
    List<GridItem> myList = [item1, item2, item3, item4, item5, item6, item4, item5, item6];
    var color = 0xFFFFFFFF;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 3, right: 3),
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          children: myList.map((data) {
            return Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(2)),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RenderHTML(touchPoint: data.touchPoint, title: "Title"))
                  );
                },
                              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Image.asset(data.icon),
                      iconSize: 100,
                      onPressed: () {Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RenderHTML(touchPoint: data.touchPoint, title: "Title"))
                  );},
                    ),
                    SizedBox(
                      height: 1,
                    ),
                   Center(
                     child: RichText(
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                      style: Theme.of(context).textTheme.headline4,            
                      children: [
                        TextSpan(text: data.title,            
                          style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF048863),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),)
                      ]
                      )
                  ),
                   ),
                   Center(
                     child: RichText(
                       maxLines: 2,
                       overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                      style: Theme.of(context).textTheme.headline4,            
                      children: [
                        TextSpan(text: data.subtitle,            
                          style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF048863),
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                        ),)
                      ]
                      )
                  ),
                   ),
                    SizedBox(
                      height: 1,
                    ),

                  ],
                ),
              ),
            );
          }).toList()),
    );
  }
}
