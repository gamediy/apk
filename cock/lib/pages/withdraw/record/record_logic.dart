import 'package:bet/utils/http.dart';
import 'package:dio/dio.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawRecordLogic extends GetxController {

  var dataList=[].obs;
  var total=0.obs;
  var pageSize = 20;
  var pageIndex = 1;
  bool hadMore = true;
  EasyRefreshController easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  void onInit() async {
    getList();
    super.onInit();
  }
  MaterialColor GetStatusColor(String status){
    if (status=="1"){
    return Colors.green;
    }
    else if(status=="2"){
    return Colors.red;
    }

    return Colors.amber;
  }
  void getList() async {
    var res = await DioUtil.instance?.request("/user/wallet/deposit/record",method: DioMethod.get, params: {
      "size": this.pageSize,
      "page": this.pageIndex,
      "Status": 1
    });
    List list = res!.data["list"];
    print(list.length);
    this.total.value=res!.data["total"];
    if (list.length < pageSize) {
      hadMore = false;
    } else {
      hadMore = true;
    }
    if (dataList.value.length==0) {
      easyRefreshController.finishRefresh();
    } else {
      easyRefreshController.finishLoad(
          hadMore ? IndicatorResult.success : IndicatorResult.noMore);
    }
     this.dataList.value.addAll(list);
    print(list);
    print(this.dataList.value.length);
   update();
  }

  Future refreshData() async{
    pageIndex=1;
    dataList.value=[];
    getList();
  }
  Future loadMoreData() async{
    if (hadMore) {
      pageIndex++;
      getList();
    } else {
      easyRefreshController.finishLoad(IndicatorResult.noMore);
    }
  }
  @override
  void onClose() {
    easyRefreshController.dispose();
    super.onClose();
  }
}
