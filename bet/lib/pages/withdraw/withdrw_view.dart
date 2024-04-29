import 'package:bet/theme/theme_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../com/user_info.dart';
import '../../router/name.dart';
import '../component/bottom.dart';
import 'withdraw_logic.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  @override
  Widget build(BuildContext context) {
    final logic = Get.put(WithdrawLogic());
    final userCom = Get.put(UserInfoCom());
    //ScreenUtil.init(context, designSize: const Size(750, 1334));
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          primary: false,
          title: Text("Withdraw",style: TextStyle(color: Colors.white),),
          leading: BackButton(
            color: Colors.white,
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Name.WithdrawRecord);
              },
              icon: Icon(
                Icons.receipt_outlined,
                color: Colors.white,
              ),
            )
          ]),
      body: GetBuilder<WithdrawLogic>(builder: (logic) {
        return SingleChildScrollView(
          child: Container(
            color: ThemeStyle.BgColor1,
            child: Form(
              key: logic.inputKey,
              autovalidateMode: AutovalidateMode.always,
              child: Stack(
                children: [
                  Container(
                    height: 1.sh - 60,
                    width: 1.sw,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "Net",
                            style: TextStyle(
                                color: ThemeStyle.txtColor, fontSize: 16),
                          ),
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Container(
                          height: 65 * logic.list.length.toDouble(),
                          child: ListView.builder(
                              itemCount: logic.list.length,
                              itemBuilder: (c, i) {
                                return InkWell(
                                  child: Obx(
                                    () => Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          border: logic.selectItemIndex.value ==
                                                  i
                                              ? Border.all(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  width: 2)
                                              : null),
                                      alignment: Alignment.center,
                                      height: 60,
                                      width: 1.sw,
                                      child: Container(
                                        color: ThemeStyle.Color1,
                                        child: ListTile(
                                          onTap: () {
                                            logic.fee.value= logic.list[i]["fee"].toString();
                                            logic.selectItemIndex.value = i;
                                          },
                                          title: Text(logic.list[i]["title"]),
                                          subtitle: Text(logic.list[i]["detail"]),

                                          trailing:
                                              logic.selectItemIndex.value == i
                                                  ? Icon(
                                                      Icons.done,
                                                      color: Colors.deepPurple,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .arrow_right_outlined,
                                                      color: Colors.deepPurple,
                                                    ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),

                        Column(
                          children: [
                            Container(
                                height: 50,
                                padding: EdgeInsets.only(top: 0, bottom: 10),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Address",
                                  style: TextStyle(
                                    color: ThemeStyle.txtColor,
                                    fontSize: 16,
                                  ),
                                )),
                            Container(
                              child: TextFormField(
                                controller: logic.accountTextController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  filled: true,

                                  fillColor: ThemeStyle.Color1, // 选择你喜欢的颜色
                                ),
                                validator: (account) {
                                  if (account == null || account.isEmpty) {
                                    return "Please enter address";
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                height: 50,
                                padding: EdgeInsets.only(top: 0, bottom: 10),
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Amount",
                                  style: TextStyle(
                                      color: ThemeStyle.txtColor, fontSize: 16),
                                )),
                            Container(
                              child: TextFormField(
                                validator: (amount) {

                                  if (amount == null || !amount.isNum) {

                                    return "Please enter the correct amount";
                                  }
                                  logic.setAmount(amount!);

                                },
                                controller: logic.amountTextController,
                                decoration: InputDecoration(

                                  suffix: InkWell(
                                    onTap: () {
                                      logic.amountTextController.text = "123";
                                      print("all selet");
                                    },
                                    child: Container(
                                      child: Text(
                                        "All",
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),

                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: ThemeStyle.Color1, // 选择你喜欢的颜色
                                ),
                              ),
                            ),

                            Obx(() =>    Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Available Balance:",
                                    style: TextStyle(
                                        color: ThemeStyle.txtColor,
                                        fontSize: 12),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${userCom.userInfo.value.balance.toString()}",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ],
                              ),
                            ))

                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey,
                            width: 1.sw,
                            height: 1,
                          ),
                          Container(
                            width: 1.sw,
                            height: 110,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Obx(() =>  Container(
                                  padding: EdgeInsets.only(left: 20, top: 10),
                                  height: 130,
                                  width: 200,
                                  //color: Colors.redAccent,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Received",
                                        style: TextStyle(
                                            color: ThemeStyle.txtColor,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        logic.amount.value,
                                        style: TextStyle(
                                            color: ThemeStyle.txtColor,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),

                                  Row(
                                    children: [
                                      Text(
                                        "Fee ",
                                        style: TextStyle(
                                          color: ThemeStyle.txtColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        logic.fee.value,
                                        style: TextStyle(
                                          color: ThemeStyle.txtColor,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  )

                                    ],
                                  ),
                                ),),
                                Obx(() =>   Container(
                                  //alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 10),
                                  height: 60,
                                  width: 120,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      logic.confirm();
                                    },
                                    color: Colors.deepPurpleAccent,
                                    child: logic.isLoading.value
                                        ? CircularProgressIndicator(
                                      valueColor:
                                      AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                        : Text(
                                      'Confirm',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(5.0)),
                                  ),
                                ))

                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      }),
      // bottomNavigationBar: Bottom.bottomNavigationBar()
    );
  }
}
