


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

class ConfirmLogic extends GetxController {

 late TextEditingController cardNumberController ;
 late TextEditingController nameController;
  late TextEditingController amountController;
  File? imageFile;
  final picker = ImagePicker();
  var data=null;
  var imagePath="".obs;
  var loading=false.obs;
  @override
  void onInit() {
      data=Get.arguments;
      if(data==null){
        data={
          "title":"",
          "amount":0,
          "address":""
        };

      }

      int amount=data["amount"];
      amountController = TextEditingController(text: amount.toString());
      nameController = TextEditingController(text: data["title"]);
      cardNumberController = TextEditingController(text: data["address"]);

    super.onInit();
  }
  Future<void> pickImage() async {
     final pickedFile = await picker.pickImage(source: ImageSource.camera);
     print(pickedFile!.path);
     uploadImageToServer(pickedFile!.path);
   //  imageFile = pickedFile != null ? File(pickedFile.path) : null;
     update();

  }
  String generateUniqueFileName(String originalFileName) {

    // 获取文件的扩展名
    String fileExtension = "png";

    // 生成一个随机的字符串，作为文件名的一部分
    String randomString = Random().nextInt(10000).toString();

    // 使用时间戳生成唯一文件名
    String uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_$randomString.$fileExtension';

    return uniqueFileName;
  }
  void uploadImageToServer(String path) async {
    try {

      XFile file = XFile(path);
      Uint8List content = await file.readAsBytes();
      // 创建 Dio 实例
      var   dio =  dio1.Dio();

      String uniqueFileName = generateUniqueFileName(file.name);
      final formData = dio1.FormData.fromMap({
        'name': 'dio',
        'date': DateTime.now().toIso8601String(),
        'file': await dio1.MultipartFile.fromBytes(content, filename: uniqueFileName),
      });

      // 构建 FormData 对象，包含要上传的文件

    var data= await DioUtil.instance?.request("/user/upload",method: DioMethod.post,data: formData);

    this.imagePath.value=data!.data;
  update();

      // 在这里处理服务器的响应
      // 可能的处理包括显示成功消息、更新 UI 等
    } catch (error) {
      // 处理上传过程中的错误
      print(error);
    }
  }

  void deleteImage(){
        this.imagePath.value="";
        update();
  }
  confirm() async{
    if(!amountController.text.isNum||amountController.text=="0"){
      Utils.Toast("Wrong amount", "Please re-enter the amount", false, SnackPosition.BOTTOM);
      return;
    }
    if(this.imagePath.value==""){
      Utils.Toast("Wrong screenshot", "Please upload transfer screenshots", false, SnackPosition.BOTTOM);
      return;
    }
    var data= await DioUtil.instance?.request("/user/wallet/deposit/create",method: DioMethod.post,data: {
      "payId": this.data["payId"],
      "amount": amountController.text,
      "transferOrderNo": "",
      "transerImg": this.imagePath.value
    });
    if(data!.code==0){
      Utils.Toast("Submitted successfully", "Please wait for customer service review", true, SnackPosition.TOP,(status){
          if(status==SnackbarStatus.CLOSED){
            Get.offNamed(Name.Deposit);
          }
      });
      return;
    }
  }

}