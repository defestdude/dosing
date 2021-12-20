import 'package:flutter/material.dart';
import 'package:nascp/screens/html_renderer.dart';
import 'package:nascp/utils/GridItems.dart';

class GridBuilder extends StatelessWidget {
  List<GridItem> gridItems;
  String pageTitle;
  GridBuilder(this.gridItems, this.pageTitle);  //constructor

   @override
  Widget build(BuildContext context) {
   // List<GridItem> myList = [item1, item2, item3, item4, item5, item6, item4, item5, item6];
    var color = 0xFFFFFFFF;
    return Flexible(
      child: GridView.count(
          childAspectRatio: 1.0,
          padding: EdgeInsets.only(left: 3, right: 3),
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          children: gridItems.map((data) {
            return Container(
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(2)),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).push(_createRoute(RenderHTML(touchPoint: data.touchPoint, title: pageTitle)));
                  /*Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RenderHTML(touchPoint: data.touchPoint, title: pageTitle))
                  );*/
                },
                              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      color: Colors.white,
                      icon: Image.asset(data.icon),
                      iconSize: 80,
                      onPressed: () {
                       /* Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RenderHTML(touchPoint: data.touchPoint, title: pageTitle))
                  );*/
                  Navigator.of(context).push(_createRoute(RenderHTML(touchPoint: data.touchPoint, title: pageTitle)));
                  },
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

  Route _createRoute(var routeDestination) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => routeDestination,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}