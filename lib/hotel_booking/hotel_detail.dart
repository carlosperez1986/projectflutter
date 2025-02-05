import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:projectflutter/hotel_booking/hotel_app_theme.dart';
import 'package:projectflutter/hotel_booking/model/hotel_list_data.dart';
import 'package:flutter/animation.dart';
import 'dart:math'; 

class HotelDetailScreen extends StatefulWidget {
  final HotelListData hotelList;
  const HotelDetailScreen({Key key, this.hotelList, this.animationController}) : super(key: key);

  final AnimationController animationController;

  @override
  _HotelDetailScreenState createState() => _HotelDetailScreenState();

}

class _HotelDetailScreenState extends State<HotelDetailScreen>
    with TickerProviderStateMixin {
  Animation<double> topBarAnimation;
  List<Widget> listViews = <Widget>[];
  
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
 
 
  @override
  void initState() {

    super.initState();
  }
Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 20,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        // "\$20",
       
        "\$" + "lesson.price.toString()",
        style: TextStyle(color: Colors.white),
      ),
    );
 
        final topContentText = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 120.0),
            Icon(
              Icons.directions_car,
              color: Colors.white,
              size: 40.0,
            ),
            Container(
              width: 90.0,
              child: new Divider(color: Colors.green),
            ),
            SizedBox(height: 10.0),
            Text( widget.hotelList.titleTxt,
              //hotelList.titleTxt,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "lesson.level",
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      "lesson.content",
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {},
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
              Text("TAKE THIS LESSON", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return  Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold( 
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    )));
  }

    }