import 'package:bet/pages/deposit/confirm/confirm_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../theme/theme_style.dart';
import 'confirm_logic.dart';

class ConfirmUsdt extends StatelessWidget {
  const ConfirmUsdt({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ConfirmUsdtLogic());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: BackButton(
              color: Colors.white,
            ),
            title: Text('${logic.data["title"]}  ${logic.data["detail"]}',style: TextStyle(
              color: Colors.white
            ),),
          ),
          body: GetBuilder<ConfirmUsdtLogic>(
            builder: (logic) {
              return SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            QrImageView(
                              data: logic.data["address"],
                              version: QrVersions.auto,
                              size: 180.0,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    enabled: false,
                                    controller: logic.addressController,
                                    decoration:
                                    InputDecoration(labelText: 'Deposit Address'),
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.deepPurpleAccent),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.content_copy),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                      text: logic.data["address"],
                                    ));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Card number copied')),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Container(
                              child: TextField(
                                enabled: false,
                                controller: logic.netController,
                                decoration:
                                InputDecoration(labelText: 'Net'),
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.deepPurpleAccent),
                              ),
                            ),

                          ],
                        ),


                        SizedBox(height: 16.0),

                     Container(
                       height: 30,
                       width: 1.sw,
                       child: Column(children: [
                                Text("最小充值金额:0.01")
                       ],),
                     ),

                        SizedBox(height: 16.0),

                      ],
                    ),
                  ),
                ),
              );
            },
          )),
    );
  }
}
