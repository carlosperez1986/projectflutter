 import 'package:projectflutter/chat/chat.dart';
import 'package:projectflutter/hotel_booking/hotel_app_theme.dart';
import 'package:projectflutter/hotel_booking/hotel_list_screen.dart';
import 'package:projectflutter/login/Login.dart';

import 'model/hotel_list_data.dart';
import 'package:flutter/material.dart'; 
import 'package:projectflutter/fintness_app_theme.dart';
import 'package:projectflutter/bottom_navigation_view/bottom_bar_view.dart';
import 'package:projectflutter/model/tabIcon_data.dart';
import 'package:flutter/animation.dart';
class HotelHomeScreen extends StatefulWidget {
  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
      
  AnimationController animationController;
  List<HotelListData> hotelList = HotelListData.hotelList; 

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
 
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  
 // Widget tabBody = Container(color: Color(0xFFF2F3F8));

  Widget tabBody = Container(
    color: FintnessAppTheme.background,
  );

  TabController controller;
  String newtitle = "bottom";
  @override
  void initState() 
  {    
    super.initState();
    
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000), vsync: this);
      tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });

    tabIconsList[0].isSelected = true;

    controller = TabController(length: 1, vsync: this);

    animationController =
        AnimationController(duration: Duration(milliseconds: 600), vsync: this);

    tabBody = MyDiaryScreen(animationController: animationController);
 
  }
 
  @override
  void dispose() {
    controller.dispose();
    animationController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(

        child: Scaffold( 
          
        body:  tabBody,
        bottomNavigationBar:  
          BottomBarView( 
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (index) {
            if (index == 0) {
                animationController.reverse().then((data) {
                if (!mounted) return;
                setState(() {
                  newtitle="1";
                  tabBody = MyDiaryScreen(animationController: animationController); 
                  
                }); 
              }); 
            } 
            else if (index == 1 || index == 3) 
            {
              animationController.reverse().then((data) {
                if (!mounted) return;
                setState(() {
                   newtitle="Login";
                  tabBody = LoginScreen();
                });
              });
            }
            else if (index == 2) 
            {
                setState(() {
                   newtitle="Chat";
                  tabBody = ChatScreen();
                });
            }
          }
               )
               )
               )

                      );
         
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
