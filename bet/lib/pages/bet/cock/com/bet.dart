import 'package:bet/theme/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_animations/animation_builder/loop_animation_builder.dart';

import '../../../../utils/values.dart';

class CockBet extends StatelessWidget {
  const CockBet({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CockBetLogic());
    return Column(
      children: [
        // Container(
        //   height: 40,
        //   margin: EdgeInsets.only(left: 5),
        //   decoration: BoxDecoration(
        //       border: Border(
        //           bottom: BorderSide(
        //     color: Values.Grey1,
        //   ))),
        //   alignment: Alignment.centerLeft,
        //   child: Text(
        //     "Bet click",
        //     style: TextStyle(
        //       fontWeight: FontWeight.w500,
        //       fontSize: 16,
        //       color: ThemeStyle.txtColor,
        //     ),
        //   ),
        // ),
        LoopAnimationBuilder<double>(
            tween: Tween(begin: 20.0, end: 30.0), // 100.0 to 200.0
            duration: const Duration(seconds: 1), // for 1 second
            builder: (context, value, _) {
              return Container(
                margin: EdgeInsets.fromLTRB(0, 5, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 120,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(232, 65, 24, 1),
                              boxShadow: [
                                BoxShadow(color: Colors.red, blurRadius: value)
                              ],
                              border: Border.all(
                                  color: Color.fromRGBO(194, 54, 22, 1),
                                  width: logic.play == "Big" ? 3 : 0)),
                          child: Column(
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 40,
                                  color: Color.fromRGBO(194, 54, 22, 1),
                                  child: Text(
                                    "BIG",
                                    style: Values.FontWhite16w,
                                    textAlign: TextAlign.center,
                                  )),
                            ],
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        height: 120,
                        decoration: BoxDecoration(
                            color: Values.BlueBet,
                            boxShadow: [
                              BoxShadow(color:Values.BlueBet, blurRadius: value)
                            ],
                            border: Border.all(
                                color:Values.BlueBet2,
                                width: logic.play == "Small" ? 3 : 0)),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: 40,
                                color: Values.BlueBet2,
                                child: Text(
                                  "Small",
                                  style: Values.FontWhite16w,
                                  textAlign: TextAlign.center,
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
        Container(
          child: GridView.builder(
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              itemCount: logic.moneyList.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 1 / 0.5,
              ),
              itemBuilder: (context, index) {
                return Material(
                  child: InkWell(
                    onTap: () {
                      logic.SelectMoneyIndex(index);
                    },
                    child: Stack(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(color: ThemeStyle.Color1),
                            width: 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: Text(
                              logic.moneyList[index] <= 1
                                  ? (logic.moneyList[index] * 100).toString() +
                                      "%"
                                  : logic.moneyList[index].toString(),
                              style: TextStyle(color: ThemeStyle.txtColor),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Expanded(
              flex: 1,
              child:   Container(
                height: 50,
                width: 0.6.sw,
                child: TextFormField(
                  controller: logic.inputController,
                  decoration: new InputDecoration(
                      labelStyle: new TextStyle(
                          fontSize: 15.0,
                          color: Color.fromARGB(255, 93, 93, 93)),
                      border: OutlineInputBorder(),
                      suffixIcon: new IconButton(
                        icon: new Icon(Icons.delete),
                        onPressed: () {
                          logic.inputController.text = "";
                        },
                      )),
                ),
              ),
            ),

          Expanded(
            flex: 1,
            child:  Container(
              height: 55,
              padding: EdgeInsets.only(left: 5),
              child: MaterialButton(
                onPressed: () {},
                color: Values.MainColor,
                child: Text(
                  "Bet confirm",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
              ),
            ) ,
          ),


            ],
          ),
        ),

      ],
    );
  }
}

class CockBetLogic extends GetxController {
  String play = "";
  TextEditingController inputController = TextEditingController();
  List<double> moneyList = [100, 300, 500, 1000, 0.1, 0.25, 0.5, 1];
  int moneyIndex = -1;
  double balance = 0;

  void SelectPlay(play) {
    print(play);
    this.play = play;
    update();
  }

  SelectMoneyIndex(index) {
    this.moneyIndex = index;
    var money = moneyList[index];
    inputController.text = money.toString();
    if (money <= 1) {
      inputController.text = (money * balance).toString();
    }
    update();
  }
}
