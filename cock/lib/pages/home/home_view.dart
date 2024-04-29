import 'package:bet/model/home.dart';
import 'package:bet/pages/agent/agent_view.dart';
import 'package:bet/pages/game/game_view.dart';
import 'package:bet/pages/home/home_logic.dart';
import 'package:bet/pages/my/my_view.dart';
import 'package:bet/theme/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var logic=Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {

    return GetBuilder<HomeLogic>(
      builder: (logic) {
        return Scaffold(
          body: IndexedStack(
            index: logic.currentIndex,
              children: logic.body),
          bottomNavigationBar: BottomAppBar(
            height: 60,
            padding: EdgeInsets.all(0),
              color: ThemeStyle.BgColor1,
              child: BottomNavigationBar(

                backgroundColor: ThemeStyle.BgColor1,
                  type:BottomNavigationBarType.fixed,
                  currentIndex: logic.currentIndex,
                 // selectedItemColor: Colors.deepPurpleAccent,
                  onTap: (index) {
                   logic.setBody(index);
                    // Get.offAllNamed("/" + i.name.toLowerCase());
                  },
                  items: logic.Items())),
        );
      },
    );
  }


}
