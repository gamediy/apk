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

import 'deposit_logic.dart';

class DepositUsdtPage extends StatefulWidget {
  @override
  _DepositUsdtPage createState() => new _DepositUsdtPage();
}

class _DepositUsdtPage extends State<DepositUsdtPage> {
  @override
  void initState() {
    super.initState();
  }

  final logic = Get.put(DepositUsdtLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              primary: false,
              title: const Text(
                "Deposit-USDT",
                style: TextStyle(color: Colors.white),
              ),
              leading: const BackButton(
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
          body: GetBuilder<DepositUsdtLogic>(
            assignId: true,
            builder: (logic) {
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: 1.sw,
                    child: Image.asset("assets/images/deposit.png"),
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
                              margin: EdgeInsets.all(5),
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
                                      trailing: Icon(Icons.chevron_right),
                                      onTap: () {
                                        logic.Deposit(
                                            logic.list[index], index);
                                      },
                                    ),
                                  ],
                                ));
                          }),
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
