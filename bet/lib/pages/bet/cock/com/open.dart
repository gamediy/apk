import 'dart:math';

import 'package:bet/pages/bet/cock/com/chart.dart';
import 'package:bet/pages/login/login_logic.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../model/open_result.dart';
import '../../../../theme/theme_style.dart';
import '../../../../utils/values.dart';

class Open extends StatelessWidget {

  const Open({super.key});

  @override
  Widget build(BuildContext context) {
    final logic=Get.put(OpenLogic());

    return Container(
        width: double.infinity,
        height: 80,
        child: Column(
          children: [

            Container(
              height: 20,
              alignment: Alignment.bottomRight,
              child: InkWell(
                onTap: (){
                  logic.showTrendchart(logic.result);
                },
                child: Text("Trend chart",style: TextStyle(
                  color: Colors.blueAccent
                ),),
              ),
            ),
            Container(
              height: 60,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: logic.issueList,
                ),
              ),
            ),
          ],

        ));
  }
}

class OpenLogic extends GetxController{
  List<OpenResult> result=[];
  List<Widget> issueList = [];
  String select = "";
  GlobalKey dataKey = GlobalKey();
  Widget OpenItem(String issue , int openresult) {
    return Row(
      key: issue == select ? dataKey : null,
      children: [
        ClipOval(
          child: Container(
            width: 50,
            height: 50,
            color: openresult > 4 ? Colors.red : Colors.blue,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    issue,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
        SizedBox(
          width: 5,
        )
      ],
    );
  }

  @override
  void onInit() {

    issueList = [
      Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0.5.sw - 5, 0),
          child: CircularProgressIndicator())
    ];
    for(var i=0;i<102;i++){
      int randomValue = Random().nextInt(2) * 2 + 1;
      result.add(OpenResult(result: randomValue, issue: i));
      issueList.add(OpenItem(i.toString(), i));
    }

    update();


    WidgetsBinding.instance?.addPostFrameCallback((callback) {});

    super.onInit();
  }

  void showTrendchart(List<OpenResult> result){
    print(result);
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          minHeight: 200, // 设置最小高度
            // 设置最小宽度
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          color: ThemeStyle.BgColor1,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 70,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Chart(result: result,),
      )
    );
  }

}
