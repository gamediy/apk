import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../router/name.dart';
import '../../utils/http.dart';
import '../../utils/utils.dart';

class LoginLogic extends GetxController {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  late String userName;
  late String password;
  var isShowPassWord = false.obs;
  var isLoading = false.obs;
  void login() async {

    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if (loginForm!.validate()) {
      isLoading.value=true;
      update();
      loginForm.save();

      var data = {"password": password, "account": userName};
      var res = await DioUtil.instance?.request("/user/user/login",
          method: DioMethod.post, data: data);
      isLoading.value=false;
      var code = res?.code;

      if (code == -1) {
        String? message=res?.msg;
        Utils.Toast("Login", message!,false,SnackPosition.TOP);
        return;
      }
      var token=res?.data["token"];

      var prefs = await SharedPreferences.getInstance();
      prefs.setString(Utils.TokenKey, token);

      Get.offAllNamed(Name.Home);



      //Navigator.of(context).pushNamed("/deposit");


    }
  }

  void showPassWord() {
      isShowPassWord.value = !isShowPassWord.value;

  }
}
