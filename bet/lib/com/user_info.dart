

import 'package:bet/model/user_info.dart';
import 'package:bet/utils/http.dart';
import 'package:get/get.dart';

class UserInfoCom extends GetxController {


late Rx<UserInfo> userInfo;
 @override
  void onInit() {
  userInfo=UserInfo(account: "", email: "", xid: "", phone: "", realName: "",
      createdAt: "", payPassStatus: 0, balance: 0, totalBet: 0,
      totalDeposit: 0, totalWithdraw: 0, freeze: 0, totalProfit: 0,
      totalGift: 0).obs;
    // TODO: implement onInit
   GetUserInfo();
    super.onInit();

  }

   void GetUserInfo()  async {
   
   var data=await DioUtil.instance!.request("/user/user/info",method: DioMethod.get);

   var model=UserInfo.fromJson(data.data);
   this.userInfo.value=model;

   }
  
}