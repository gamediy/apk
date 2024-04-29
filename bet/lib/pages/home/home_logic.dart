import 'package:bet/pages/bet/cock/cock_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/home.dart';
import '../agent/agent_view.dart';
import '../game/game_view.dart';
import '../my/my_view.dart';

class HomeLogic extends GetxController {
  var currentIndex = 0;
 Widget currentBody=MyPage();

 var list = [
    HomeModel(title: "Play",name: "Game",icon: FaIcon(FontAwesomeIcons.gamepad),widget: GamePage()),
    HomeModel(title: "Order",name: "Order",icon: FaIcon(Icons.list),widget: AgentPage()),
    HomeModel(title: "Agent",name: "Agent",icon: FaIcon(FontAwesomeIcons.dollar),widget: AgentPage()),
    HomeModel(title: "My",name: "My",icon: FaIcon(FontAwesomeIcons.user),widget: MyPage()),
  ];
 List<Widget> body=[];
 @override
  void onInit() {
    // TODO: implement onInit
   list.forEach((element) {
   body.add(element.widget);
   });

    super.onInit();
  }
 void setBody(index){
   this.currentIndex=index;
   this.currentBody=list[index].widget;
    update();
 }
  List<BottomNavigationBarItem> Items() {
    List<BottomNavigationBarItem> items = [];
    this.list.forEach((item) {


      items.add(BottomNavigationBarItem(

        icon: item.icon,
        label: item.name,
        activeIcon: Icon(item.icon.icon, color: Colors.deepPurpleAccent),

      ));
    });
    return items;
  }
}