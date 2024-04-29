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
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            primary: false,
            automaticallyImplyLeading: true,
            title: Text("Deposit record"),
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
                  return Container();
                },
                itemBuilder: (BuildContext context, int realIndex) {
                  return Padding(
                    padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: ThemeStyle.BgColor1,
                        borderRadius: BorderRadius.circular(5),
                      ),

                     // color: Colors.white,
                     // decoration: ThemeStyle.BoxBorderRadius,
                      child: ListTile(
                        leading: CircleAvatar(
                          foregroundColor: Theme.of(context).primaryColor,
                          backgroundColor: Colors.teal,
                          child: Text(
                            "USDT",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                        isThreeLine: true,
                        title: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                logic.dataList.value[realIndex]["amount"]
                                    .toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                        ),
                        subtitle: Container(
                          height: 20,
                          margin: EdgeInsets.only(top:20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                logic.dataList.value[realIndex]["orderNo"],
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12.0),
                              ),
                              Text(
                                logic.dataList.value[realIndex]["createdAt"] ??
                                    "",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
