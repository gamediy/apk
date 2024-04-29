import 'package:bet/com/user_info.dart';
import 'package:bet/utils/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';

class WithdrawLogic extends GetxController {

  var balance=0.obs;
  var isLoading=false.obs;
  var amount="0".obs;
  var fee="".obs;
  List<dynamic> list = <dynamic>[].obs;
  var selectIndex = -1;
  var pressed = false;

  RxInt selectItemIndex = (-1).obs;
  GlobalKey<FormState> inputKey = new GlobalKey<FormState>();
  TextEditingController amountTextController = new TextEditingController();
  TextEditingController accountTextController = new TextEditingController();

   late UserInfoCom  userInfoCom;
  @override
  void onInit() async{
    this.userInfoCom = Get.put(UserInfoCom());


      this.getItem();
  }
  getItem() async {
      var data= await DioUtil.instance!.request("/user/wallet/withdraw/item",method: DioMethod.get);
      var item=data.data["item"];
      list.addAll(item);
      update();
  }
  void confirm() async {
    if(this.isLoading.value){
      return;
    }
      this.isLoading.value=true;
    if(selectItemIndex.value<0){
      Utils.Toast("Withdraw", 'Please choose to pay', false,
          SnackPosition.TOP);
      this.isLoading.value=false;
      return;
    }
    final FormState? form = inputKey.currentState;

    // 如果表单有效，则执行保存操作
    if (form != null && form.validate()) {
      form.save(); // 调用 save 方法保存表单
      var res=await DioUtil.instance!.request("/user/wallet/withdraw/create",data: {

          "amountItemId": this.list[this.selectItemIndex.value]["withdrawId"],
          "amount": this.amountTextController.text,
          "withdrawAccount": this.accountTextController.text,
          "withdrawAccountId": 0,
           "title":""

      });
      this.isLoading.value=false;
      if(res.code!=0){
        Utils.Toast("Withdraw", res.msg, false, SnackPosition.TOP);
        return;
      }
      this.amountTextController.text="";
      this.accountTextController.text="";
      userInfoCom.GetUserInfo();
      this.setAmount("");
      Utils.Toast("Withdraw", "Withdrawal submission successful", true, SnackPosition.BOTTOM);
    }else{
      this.isLoading.value=false;
    }

  }

  void  setAmount(String amount){
    this.amount.value=amount;
    //update();
  }
}
