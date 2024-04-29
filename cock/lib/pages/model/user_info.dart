import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserInfo extends GetxController {
  var Token="".obs;
  RxDouble  Balance=0.0.obs;
  setToken(String token){
    this.Token.value=token;
  }
  setBalance(double balance){
    this.Balance.value=balance;
  }
}