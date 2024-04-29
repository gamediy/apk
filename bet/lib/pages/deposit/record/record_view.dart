import 'package:bet/pages/deposit/record/record_logic.dart';
import 'package:bet/theme/theme_style.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DepositRecordPage extends StatelessWidget {
  DepositRecordPage({Key? key}) : super(key: key);
  final logic = Get.put(DepositRecordLogic());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DepositRecordLogic>(
      builder: (logic) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              primary: false,
              automaticallyImplyLeading: true,
              title: ThemeStyle.Title("Deposit record"),
              leading: BackButton(
                onPressed: () {
                  print("back");
                  Get.back();
                },
                color: Colors.white,
              ),
            ),
            body: Container(
              child: EasyRefresh(
                onRefresh: logic.refreshData,
                onLoad: logic.loadMoreData,
                child: ListView.separated(
                  itemCount: logic.dataList.value.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 1,
                    );
                  },
                  itemBuilder: (BuildContext context, int realIndex) {
                    return Container(
                    margin: EdgeInsets.only(left: 1,right: 1),
                      decoration: BoxDecoration(
                        color: ThemeStyle.BgColor1,
                        borderRadius: BorderRadius.circular(5),
                      ),
          
                      // color: Colors.white,
                      // decoration: ThemeStyle.BoxBorderRadius,
                      child: ListTile(
                        leading: Container(
                          child: CircleAvatar(
                            foregroundColor: Theme.of(context).primaryColor,
                            backgroundColor: Colors.teal,
                            child: const Text(
                              "USDT",
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        //isThreeLine: true,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              logic.dataList.value[realIndex]["amount"]
                                  .toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              logic.dataList.value[realIndex]["statusRemark"],
                              style: TextStyle(
                                color: logic.GetStatusColor(
                                    logic.dataList.value[realIndex]["status"]),
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              logic.dataList.value[realIndex]["orderNo"],
                              style:
                                  const TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                            Text(
                              logic.dataList.value[realIndex]["createdAt"] ?? "",
                              style:
                                  const TextStyle(color: Colors.grey, fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
