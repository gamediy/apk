import 'package:bet/model/category.dart';
import 'package:bet/pages/bet/model/BetMenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class BetLogic extends GetxController with GetTickerProviderStateMixin {
  var category=0.obs;
  var gameCoode=1000;

  @override
  void onInit() async {

    ever(category, (value)  {
      print(value);
      print("Category");
    });

    super.onInit();


    @override
    void onClose() {
      super.onClose();
    }
  }
}
