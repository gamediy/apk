import 'package:bet/pages/bet/cock/cock_logic.dart';
import 'package:bet/pages/bet/cock/com/balance.dart';
import 'package:bet/pages/bet/cock/com/bet.dart';
import 'package:bet/pages/bet/cock/com/chart.dart';
import 'package:bet/pages/bet/cock/com/history.dart';
import 'package:bet/pages/bet/cock/com/issue.dart';
import 'package:bet/theme/theme_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import '../../../utils/values.dart';
import 'com/open.dart';
import 'com/video.dart';

class CockView extends StatefulWidget {
  @override
  _CockState createState() => _CockState();
}

class _CockState extends State<CockView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CockLogic());

    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
          body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            // VideoCock(),
            Divider(),
            CockIssue(),

            CockBet(),
            Balance(),
            Divider(),
            Open(),
            History(),
            //Chart(),
          ]),
        ),
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
