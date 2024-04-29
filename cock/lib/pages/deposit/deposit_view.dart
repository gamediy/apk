

import 'package:bet/pages/deposit/deposit_logic.dart';
import 'package:bet/router/name.dart';
import 'package:bet/theme/theme_style.dart';
import 'package:bet/utils/http.dart';
import 'package:bet/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DepositPage extends StatefulWidget {
  @override
  _DepositPage createState() => new _DepositPage();
}

class _DepositPage extends State<DepositPage> {
  @override
  void initState() {
    super.initState();
  }

  final logic = Get.put(DepositLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            primary: false,
            title: Text("Deposit"),
            leading: BackButton(
              color: Colors.white,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(Name.DepositRecord);
                },
                icon: Icon(
                  Icons.receipt_outlined,
                  color: Colors.white,
                ),
              )
            ]),
        body: GetBuilder<DepositLogic>(
          assignId: true,
          builder: (logic) {
            return Stack(
              children: [
                Container(
                  color: ThemeStyle.BgColor1,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                          height: 30,
                          padding: EdgeInsets.only(top: 0, bottom: 10),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Amount",
                            style: TextStyle(
                              color: ThemeStyle.txtColor,
                              fontSize: 16,
                            ),
                          )),
                      Container(
                        child: Form(
                          key: logic.inputKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Container(
                              height: 80.0,
                               decoration: BoxDecoration(

                               ),
                              child: TextFormField(
                                controller: logic.amountTextController,
                                style: TextStyle(fontSize: 16),
                                // 设置字体大小
                                decoration: new InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0), // 设置圆角半径
                                  ),
                                  filled: true,
                                  fillColor: ThemeStyle.Color1,
                                  hintText: '',
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.only(left: 0, right: 0),
                                    child: new IconButton(
                                      icon: Icon(Icons.clear),
                                      onPressed: () {
                                        logic.amountTextController.text = "";
                                      },
                                    ),
                                  ),
                                ),
                                validator: (money) {
                                  if (money == null || money.isEmpty) {
                                    return "Select amount or enter ";
                                  }
                                  var m = double.parse(money);
                                  if (m <= 0) {
                                    return "Select amount or enter ";
                                  }
                                },
                                onSaved: (value) {
                                  print("222");
                                  setState(() {
                                    logic.amount.value = double.parse(value!);
                                  });
                                },
                              )),
                        ),
                      ),
                      Container(
                        child: GridView.builder(
                            itemCount: logic.money.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 20,
                              childAspectRatio: 1 / 0.5,
                            ),
                            itemBuilder: (context, index) {
                              return Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    logic.amountTextController.text =
                                        logic.money[index].toString();
                                    setState(() {
                                      logic.selectIndex = index;
                                    });
                                  },
                                  child: Container(
                                    decoration: logic.selectIndex == index
                                        ? BoxDecoration(
                                            color: ThemeStyle.Color1,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ))
                                        : BoxDecoration(
                                            color: ThemeStyle.Color1,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            )),
                                    width: 60,
                                    height: 30,
                                    alignment: Alignment.center,
                                    child: Text(
                                      logic.money[index].toString(),
                                      style: TextStyle(
                                          color: ThemeStyle.txtColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        //color: Colors.white,
                        child: Align(
                          alignment: Alignment.center,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: logic.list.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: ThemeStyle.Color1,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),

                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title:
                                              Text(logic.list[index]["title"]),
                                          subtitle: Text(
                                            logic.list[index]["detail"],
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          ),
                                          leading: Image.network(
                                              "https://img0.baidu.com/it/u=2799820758,1545153940&fm=253&fmt=auto&app=138&f=JPEG?w=540&h=336"),
                                          trailing: Icon(Icons.chevron_right),
                                          onTap: () {
                                            logic.ShowBs(index);
                                          },
                                        ),
                                      ],
                                    ));
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 70,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tips",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8), // 增加垂直间距
                        RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.grey),
                            text:
                                "test testseteste steste fdsfdsfsd \n fsfsdfdstestseteste stestetest testseteste stestetest testseteste steste",
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ));
  }
}
