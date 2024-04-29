import 'package:bet/model/amount.dart';
import 'package:bet/router/name.dart';
import 'package:bet/theme/theme_style.dart';
import 'package:bet/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../utils/http.dart';

class DepositLogic extends GetxController {
  TextEditingController amountTextController = new TextEditingController();
  List<dynamic> list = <dynamic>[].obs;
  List<double> money = <double>[
    100,
    200,
    500,
    1000,
    2000,
    3000,
    5000,
    10000,
    20000,
  ];
  var amount = 0.00.obs;
  var selectIndex = -1;
  var pressed = false;

  RxInt selectItemIndex = (-1).obs;
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> inputKey = new GlobalKey<FormState>();
  @override
  void onInit() {
    super.onInit();
    DioUtil.instance
        ?.request("/user/wallet/deposit/platform", method: DioMethod.get)
        .then((value) {
      list.addAll(value!.data["list"]);
      update();
    });
  }

  void ShowBs(int selectIndex) async {
    try {
      //读取当前的Form状态
      var loginForm = inputKey.currentState;
      //验证Form表单
      if (!loginForm!.validate()) {
        return;
      }
      var item = list[selectIndex];
      int min = item["min"];
      int max = item["max"];
      amount.value = double.parse(amountTextController.text);
      print(amount);
      if (amount < min || amount > max) {
        Utils.Toast("Deposit", 'Deposit amount minimum:$min maximum:$max',
            false, SnackPosition.TOP);
        return;
      }

      Get.bottomSheet(Container(
        height: 120*double.parse(list[selectIndex]["item"].length.toString()),
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

        //color: Colors.grey[50],

        child: Column(
          children: [
            Align(
              child: Container(
                alignment: Alignment.center,
                height: 40,
                child: Text("Please choose",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold)),
              ),
            ),
            Divider(
              color: ThemeStyle.txtColor,
            ),
            Container(
              padding: EdgeInsets.only(left: 5,right: 5),
              color: Colors.white,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: list[selectIndex]["item"].length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeStyle.Color1,
                        borderRadius: BorderRadius.circular(5.0),

                      ),
                      child: Column(
                        children: [
                          Obx(
                            () => ListTile(

                              subtitle: Text(
                                list[selectIndex]["item"][index]["detail"],
                                style: TextStyle(color: Colors.red),
                              ),
                              title:
                                  Text(list[selectIndex]["item"][index]["title"]),
                              leading: Image.network(
                                  "https://img0.baidu.com/it/u=2799820758,1545153940&fm=253&fmt=auto&app=138&f=JPEG?w=540&h=336"),
                              trailing: Icon(Icons.chevron_right),
                              onTap: () {
                                this.Deposit(
                                    list[selectIndex]["item"][index], index);
                              },
                            ),
                          )

                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ));
    } catch (e) {
      print(e);
    }
  }

  Deposit(dynamic item, int index) async {
    print(item);

    if (amount.value <= 0) {
      return Utils.Toast(
          "Deposit", "Wrong amount", false, SnackPosition.BOTTOM);
    }
    int min = item['min'];
    int max = item['max'];

    if (amount.value < min || amount.value > max) {
      Utils.Toast("Deposit", 'Deposit amount minimum:$min maximum:$max', false,
          SnackPosition.TOP);
      return;
    }
    this.selectItemIndex.value = index;
    item["amount"] = amount.value;
    Get.toNamed(Name.DepositConfirm, arguments: item);
  }

  void showDialog() {
    Get.defaultDialog(
      title: 'Deposit Details',
      content: Container(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Recharge Amount'),
              onChanged: (value) {
                this.amount.value = double.parse(value);
              },
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Card Number'),
              onChanged: (value) {},
            ),
            ElevatedButton(
              onPressed: () {
                // Handle image upload logic
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          // Handle confirmation logic
          Get.back();
        },
        child: Text('Confirm'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancel'),
      ),
    );
  }
}
