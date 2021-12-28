import 'package:flutter/material.dart';

import 'package:nascp/screens/drawer_screen.dart';
import 'package:nascp/screens/dosing_wheel/regimens.dart';
import 'package:nascp/screens/dosing_wheel/search_result.dart';
import 'package:photo_view/photo_view.dart';

class TB extends StatefulWidget {
  const TB({Key key, this.weight}) : super(key: key);

  // Declare a field that holds the Todo.
  final int weight;

  @override
  _TBState createState() => _TBState();
}

class _TBState extends State<TB> {
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  final formKey = new GlobalKey<FormState>();

  String email, password;
  bool closeTopContainer = false;
  Color greenColor = Color(0xFF0C8863);
  Color lightGreen = Color(0xFF10B875);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _chosenValue;

  //To check fields during submit
  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  //To Validate email
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return Scaffold(
        key: _scaffoldKey,
        drawer: DrawerScreen(),
        appBar: AppBar(
          title: Text("PEDS HIV Dosing Guide"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(key: formKey, child: _buildLoginForm())));
  }

  _buildLoginForm() {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: ListView(children: [
          Container(
            alignment: Alignment.topLeft,
            child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  _scaffoldKey.currentState.openDrawer();
                }),
          ),

          SizedBox(height: 15.0),
          //   Text('WHO 2020', style: TextStyle(fontFamily: 'Trueno', fontWeight: FontWeight.w500)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: 85.0,
                  width: 300.0,
                  child: Stack(
                    children: [
                      Text('Guidance for treatment of Tuberculosis (TB) among clients on antiretroviral therapy.',
                          style: TextStyle(fontFamily: 'Trueno', fontSize: 20)),
  
                    ],
                  )),
            ],
          ),
          SizedBox(height: 5.0),
          Text(
              "Confirm if the patient is on TB treatment and do the following if on the following ARVs:"),
          SizedBox(height: 10.0),
         
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0.0, -2.0),
                    child: Text(
                      '->',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextSpan(
                  text:
                      'Dolutegravir (DTG) - Double the dosage of DTG to twice daily when used with rifampicin for TB e.g., DTG 50mg will be doubled to 100mg daily dose and administered as 50mg twice daily. Adjust dosage for clients on pDTG',
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),

          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0.0, -2.0),
                    child: Text(
                      '->',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextSpan(
                  text:
                      'Lopinavir/ritonavir (LPV/r) - Super-boost the ritonavir in the fixed dose combination of LPV/r when co-administered with Rifampicin for children with TB/HIV co-infection. This can be achieved by ensuring a 1:1 ratio of lopinavir and ritonavir, as opposed to the previously used 4:1 ratio (e.g., 40/10mg or 100/25mg)',
                ),
              ],
            ),
          ),
          SizedBox(height: 5.0),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0.0, -2.0),
                    child: Text(
                      '->',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextSpan(
                  text:
                      'Raltegravir (RAL) – Double the dose of RAL by administering same dose twice daily when co-administered with Rifampicin',
                ),
              ],
            ),
          ),
          SizedBox(height: 9.0),
          RichText(
            text: TextSpan(
              style: TextStyle(
                  fontFamily: 'Trueno', color: Colors.black, fontSize: 13),
              children: [
                WidgetSpan(
                  child: Transform.translate(
                    offset: const Offset(0.0, -2.0),
                    child: Text(
                      '->',
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TextSpan(
                  text:
                      'Darunavir use is contraindicated with Rifampicin or Rifabutin',
                ),
              ],
            ),
          ),
          SizedBox(height: 50.0),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Regimens(
                  weight: widget.weight,
                ),
              ));
              //if (checkFields()) AuthService().signIn(email, password, context);
            },
            child: Container(
                height: 50.0,
                width: 350,
                child: Material(
                    borderRadius: BorderRadius.circular(25.0),
                    shadowColor: Colors.greenAccent,
                    color: greenColor,
                    elevation: 7.0,
                    child: Center(
                        child: Text('PROCEED',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Trueno'))))),
          ),
          SizedBox(height: 20.0),
        ]));
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 150;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              /* Container(
                width: 120,
                margin: EdgeInsets.only(right: 10),
                height: categoryHeight,
                decoration: BoxDecoration(color: Color(0xFF0C8863), border: Border.all(color: Colors.black45), borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Postnatal Infant ARV Prophylaxis",
                        style: TextStyle(fontSize: 13, color: Colors.white, fontFamily: 'Trueno'),
                      ),
                     Center(
                        child: ImageIcon(AssetImage('assets/images/prophy.png'),
                                size: 35.0, color: Color(0xFFFFFFFF)),
                      )
                     
                    ],
                  ),
                ),
              ),*/
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 10),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                            child: Image.asset('assets/images/who.png',
                                width: 50)),
                        Center(
                          child: Text(
                            "WHO Guidelines",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: Colors.black,
                                fontFamily: 'Trueno'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 120,
                margin: EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child:
                              Image.asset('assets/images/coa.png', width: 50)),
                      Center(
                        child: Text(
                          "National HIV Treatment Guidelines",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Trueno',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
