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

class DepositUsdtLogic extends GetxController {
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

     var listObj=value!.data["list"];
     for(var item in listObj){
       print(item["item"]);
        list.addAll(item["item"]);
       update();
     }
     print(list);

    });
  }

  Deposit(dynamic item, int index) async {
    print(item);

    this.selectItemIndex.value = index;

    Get.toNamed(Name.DepositConfirm, arguments: item);
  }




}
