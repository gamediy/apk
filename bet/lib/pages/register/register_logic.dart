import 'package:bet/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';

import '../../utils/http.dart';
class RegisterLogic extends GetxController {



  var email="";
  var password="";
  var password2="";
  var xid="";
  var isLoading = false.obs;
  @override
  void onInit() {

    super.onInit();
    xid= Get.parameters["xid"].toString();
  }
  register() async{
    if(isLoading.value){
      return;
    }
    isLoading.value = true;
    var data={
      "email": this.email,
      "account":this.email,
    "password": this.password,
    "password2": this.password2,
      "xid":this.xid
    };
    var res=await DioUtil.instance?.request("/user/user/register",data: data);
    var code = res!.code;
    isLoading.value = false;
    if(code==0){

      Get.defaultDialog(
          title: "Register",
          onConfirm: ()  {
          Get.offAllNamed("/login");
          },
          middleText: "Success going sign in",
          buttonColor: Colors.deepPurple,

      );


      // Utils.Toast("Register", "Success going sign in",true,(status){
      //   if(status==SnackbarStatus.CLOSED){
      //     Get.offAllNamed("/login");
      //   }
      // });
    }
    else{
      Utils.Toast("Register", res!.msg,false,SnackPosition.TOP);
    }




  }

}
