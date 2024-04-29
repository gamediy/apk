


import 'dart:io';

import 'dart:math';
import 'dart:typed_data';

import 'package:bet/router/name.dart';
import 'package:bet/utils/http.dart';
import 'package:bet/utils/utils.dart';
import 'package:dio/dio.dart' as dio1;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

class ConfirmUsdtLogic extends GetxController {

 late TextEditingController addressController ;
 late TextEditingController netController ;

  File? imageFile;
  final picker = ImagePicker();
  var data=null;
  var imagePath="".obs;
  var loading=false.obs;
  @override
  void onInit() {
      data=Get.arguments;
      print(data);
      if(data==null){
        data={
          "title":"",

          "address":""
        };

      }



      addressController=new TextEditingController();
      addressController.text=data["address"];

      netController=new TextEditingController();
      netController.text='${data["title"]} ${data["detail"]} ';
      this.getAccount(data["payId"]);
    super.onInit();
  }

    void   getAccount(payid) async{
    var res=await DioUtil.instance
        ?.request("/user/wallet/deposit/account", method: DioMethod.get,params: {
          "payId":payid
    });


  }






}