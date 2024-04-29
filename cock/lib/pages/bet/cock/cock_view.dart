
import 'package:cock/pages/bet/cock/com/video.dart';
import 'package:cock/pages/bet/com/bet/bet_com_view.dart';
import 'package:cock/theme/theme_style.dart';
import 'package:chewie/chewie.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';
import 'package:bet/model/category.dart';
import 'package:bet/pages/bet/com/history/history_com_view.dart';
import 'package:bet/pages/bet/com/issue/issue_com_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import 'cock_logic.dart';

class CockPage extends StatefulWidget {
  const CockPage({Key? key}) : super(key: key);

  @override
  State<CockPage> createState() => _CockPageState();
}

class _CockPageState extends State<CockPage> {
  final logic = Get.put(CockLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CockLogic>(
      assignId: true,
      builder: (logic) {
        return Scaffold(
            body: Container(
          color: ThemeStyle.BgColor1,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child:VideoCock("https://live.cloudflaregateway.com/live/playlist.m3u8")),
              ],
            ),
          ),
        ));
      },
    );
  }
}
